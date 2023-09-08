import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/markers_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';

class ViewMapBackUp extends StatefulWidget {
  const ViewMapBackUp({Key? key}) : super(key: key);

  @override
  _ViewMapBackUpState createState() => _ViewMapBackUpState();
}

class _ViewMapBackUpState extends State<ViewMapBackUp> {
  TextEditingController marker1Controller = TextEditingController();
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  Polyline? _polyline = const Polyline(
    polylineId: PolylineId('polyline1'),
  );
  List<Marker> markers = [];
  LatLng _center = const LatLng(34.006960, 71.533060);
  late List<LatLng> latLen;

  List<String> images = [
    'assets/images/driver_logo.png',
    'assets/images/marker.png',
  ];

  Future<Uint8List> getBytesFromAssets(
    String path,
  ) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void updatePolylineCoordinates(
      List<Marker> markers, List<LatLng> newLatLen, int a, int b) {
    final aPoint = newLatLen[a];
    latLen[a] = newLatLen[b];
    latLen[b] = aPoint;

    setState(() {
      makeMarkers();
    });
  }

  makeMarkers() async {
    Uint8List? driver = await getBytesFromAssets(images[0]);
    Uint8List? image = await getBytesFromAssets(
      images[1],
    );

    var markerDataList = List.generate(
        5,
        (index) => MarkerData(
            id: index.toString(), position: latLen[index], priority: index));
    markers = List.generate(5, (index) {
      return Marker(
          icon: index == 0
              ? BitmapDescriptor.fromBytes(driver)
              : BitmapDescriptor.fromBytes(image),
          markerId: MarkerId(markerDataList[index].id),
          position: markerDataList[index].position,
          onTap: index == 0
              ? null
              : () {
                  marker1Controller.text =
                      markerDataList[index].priority.toString();
                  customInfoWindowController.addInfoWindow!(
                    Container(
                      height: 80.sp,
                      width: 0.3.sw,
                      color: Colors.white,
                      padding: EdgeInsets.all(10.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Priority',
                                      style: GoogleFonts.openSans(
                                          fontSize: 12.sp, color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 10.sp),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.greyColor,
                                      width: 0.3.sp),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.greyColor,
                                      width: 0.3.sp),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.greyColor,
                                      width: 0.3.sp),
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                              controller: marker1Controller,
                              onChanged: (priority) {},
                              onSubmitted: (val) async {
                                if (int.parse(val) < latLen.length) {
                                  var oldPriority =
                                      markerDataList[index].priority;
                                  markerDataList[index].priority =
                                      int.parse(val);
                                  await updatePolyline(
                                      markerDataList, oldPriority, index);
                                  customInfoWindowController.hideInfoWindow!();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "priority should be less than ${latLen.length}")));
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    latLen[index],
                  );
                });
    });
  }

  void makePolyline(polylines) {
    _polyline = Polyline(
        polylineId: PolylineId(latLen[0].longitude.toString()),
        color: Colors.green,
        width: 5,
        points: polylines);
  }

  final MapType _currentMapType = MapType.normal;

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
    customInfoWindowController.onCameraMove!();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller; // simple googlemap controller

    customInfoWindowController.googleMapController = controller;
  }

  final Key _mapKey = UniqueKey();

  final LocationSettings locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      intervalDuration: const Duration(seconds: 1));
  // StreamSubscription<Position>? positionStream;
  var source = ValueNotifier<Position>(const Position(
      longitude: 71.5249,
      latitude: 34.0151,
      timestamp: null,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0));
  Position? currentPosition;
  var lat, lng;
  GoogleMapController? _controller;
  LatLng? sourceDistination;
  var locationLoading = ValueNotifier<bool>(true);
  var isStart = ValueNotifier<bool>(false);
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
  @override
  void initState() {
    latLen = [
      LatLng(source.value.latitude, source.value.longitude),
      const LatLng(33.9966, 71.4861),
      const LatLng(34.100, 71.533060),
      const LatLng(34.0400, 71.633200),
      const LatLng(34.0300, 71.633200),
    ];
    getPosition();

    super.initState();
  }

  updateMap() async {
    if (markers[1].position.latitude == lat &&
        markers[1].position.longitude == lng) {
      markers.removeAt(1);
    }

    await getDirections();
  }

  updatePolyline(List<MarkerData> dataList, oldPriority, index) async {
    for (var i = 0; i < dataList.length; i++) {
      if (dataList[index].priority == dataList[i].priority && index != i) {
        dataList[i].priority = oldPriority;
      }
    }

    dataList.sort((a, b) {
      return a.priority.compareTo(b.priority);
    });
    for (var i = 1; i < dataList.length; i++) {
      latLen[i] = dataList[i].position;
    }
    // makeMarkers();
    await getDirections();

    setState(() {});
  }

  getPosition() async {
    try {
      await _determinePosition();

      sourceDistination = LatLng(source.value.latitude, source.value.longitude);
      latLen[0] = sourceDistination!;
      locationLoading.value = false;
      //_getCurrentLocation();
      await makeMarkers();
      await getDirections();
      // setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      locationLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: locationLoading,
            builder: (context, value, child) {
              if (value) {
                return Center(
                  child: loadingIndicator(),
                );
              } else {
                return Stack(
                  children: <Widget>[
                    ValueListenableBuilder(
                        valueListenable: isStart,
                        builder: (context, start, child) {
                          return StreamBuilder(
                              stream: Geolocator.getPositionStream(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (start) {
                                    latLen[0] = LatLng(snapshot.data!.latitude,
                                        snapshot.data!.longitude);
                                    updateMap();
                                  }
                                }
                                return GoogleMap(
                                  zoomControlsEnabled: false,
                                  onTap: (position) {
                                    customInfoWindowController
                                        .hideInfoWindow!();
                                  },
                                  compassEnabled: true,
                                  key: _mapKey,
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: CameraPosition(
                                    target: _center,
                                    zoom: 10.0,
                                  ),
                                  mapType: _currentMapType,
                                  markers: Set.from(markers),
                                  onCameraMove: _onCameraMove,
                                  polylines: {_polyline!},
                                  myLocationEnabled: false,
                                  myLocationButtonEnabled: true,
                                );
                              });
                        }),
                    CustomInfoWindow(
                      controller: customInfoWindowController,
                    ),
                    Positioned(
                        bottom: 40,
                        left: 20,
                        right: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              isStart.value = !isStart.value;
                            },
                            child: ValueListenableBuilder(
                                valueListenable: isStart,
                                builder: (context, start, child) {
                                  if (start) {
                                    return const Text("Cancel");
                                  } else {
                                    return const Text("Start");
                                  }
                                })))
                  ],
                );
              }
            }));
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      source.value = await Geolocator.getCurrentPosition();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    source.value = await Geolocator.getCurrentPosition();
  }

  getDirections() async {
    String apiKey = 'AIzaSyBXA9WVoVwWEW__69FOe8rgqDCoz-MF9Jo';
    // List<Location> locations = await locationFromAddress(
    // 'Office no C4 fourth floor New Dil jan arcade, Peshawar Ring Rd., Achini Payan, Peshawar, Khyber Pakhtunkhwa 25000');
    String origin =
        '${latLen[0].latitude},${latLen[0].longitude}'; // Replace with the starting location
    // String origin = "${locations[0].latitude},${locations[0].longitude}";
    String destination =
        '${latLen[latLen.length - 1].latitude},${latLen[latLen.length - 1].longitude}'; // Replace with the destination location
    String wayPoints = '';
    for (var i = 1; i < latLen.length - 1; i++) {
      wayPoints += '${latLen[i].latitude},${latLen[i].longitude}|';
    }
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&waypoints=$wayPoints&&key=$apiKey';

    // Make the HTTP request
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Request successful
      try {
        var data = json.decode(response.body);

        if (data['status'] == 'OK') {
          // print(data);
          var decodePoly = await decodePolyline(
              data['routes'][0]['overview_polyline']['points']);
          await makeMarkers();

          makePolyline(decodePoly);
          setState(() {});
        } else {}
      } on SocketException catch (e) {
        debugPrint(e.toString());
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint("something went wrong");
    }
  }

  Future<List<LatLng>> decodePolyline(String encodedPolyline) async {
    List<LatLng> polylinePoints = [];
    var list = PolylinePoints().decodePolyline(encodedPolyline);
    for (int i = 0; i < list.length; i++) {
      polylinePoints.add(LatLng(list[i].latitude, list[i].longitude));
      if (i == 0) {
        latLen[0] = LatLng(list[i].latitude, list[i].longitude);

        markers[0] = markers[0].copyWith(
            positionParam: LatLng(list[i].latitude, list[i].longitude));
        if (isStart.value) {
          _controller!.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: markers[0].position, zoom: 20)),
          );
        } else {
          _controller!.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: markers[0].position, zoom: 12)),
          );
        }
      }
    }

    return polylinePoints;
  }
}

// getDirections() async {
//   String apiKey = 'AIzaSyBXA9WVoVwWEW__69FOe8rgqDCoz-MF9Jo';
//   String origin =
//       '${latLen[0].latitude}, ${latLen[0].longitude}'; // Replace with the starting location
//   String destination =
//       '${latLen[latLen.length - 1].latitude}, ${latLen[latLen.length - 1].longitude}';
//   print("Ff${latLen.length}"); // Replace with the destination location
//   latLen[1] = const LatLng(33.9966, 71.4861);
//
//   setState(() {});
//   print("Ff${latLen.length}");
//   // Request successful
//   try {
//     List<LatLng> polylinePoints = [];
//     PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
//         apiKey,
//         PointLatLng(latLen[0].latitude, latLen[0].longitude),
//         PointLatLng(latLen[latLen.length - 1].latitude,
//             latLen[latLen.length - 1].longitude));
//     print("RESULT ${result.points}");
//     print("RESULT ${result.status}");
//     print("${latLen[0].latitude}  ${latLen[0].longitude}");
//     print("${latLen[1].latitude}  ${latLen[1].longitude}");
//
//     if (result.status == 'OK') {
//       // loop through all PointLatLng points and convert them
//       // to a list of LatLng, required by the Polyline
//       for (var point in result.points) {
//         polylinePoints.add(LatLng(point.latitude, point.longitude));
//       }
//     }
//     print(polylinePoints);
//     print("*****");
//     print("*****");
//
//     await makeMarkers();
//
//     makePolyline(polylinePoints);
//     setState(() {});
//   } on SocketException catch (e) {
//     debugPrint(e.toString());
//   } catch (e) {
//     debugPrint(e.toString());
//   }
// }
