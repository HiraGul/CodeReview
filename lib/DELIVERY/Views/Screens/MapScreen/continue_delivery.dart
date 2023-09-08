import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderStatusCubit/order_status_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/PickOrdersCubit/pick_orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/UpdatePriority/update_priority_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/pick_order_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/keys.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/PickedAssignedOrders/picked_assigned_orders.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/DeliveryDetailsWidget/bottom_nav_button.dart';
import 'package:tojjar_delivery_app/commonWidgets/FlutterToast.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';

class ContinueDeliveryScreen extends StatefulWidget {
  final PageController controller;

  const ContinueDeliveryScreen({required this.controller, Key? key})
      : super(key: key);

  @override
  State<ContinueDeliveryScreen> createState() => _ContinueDeliveryScreenState();
}

class _ContinueDeliveryScreenState extends State<ContinueDeliveryScreen> {
  List<PickOrderModel> updatePriorityList = [];
  List<TextEditingController> markerController = [];
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  Polyline? _polyline = const Polyline(
    polylineId: PolylineId('polyline1'),
  );
  List<Marker> markers = [];
  LatLng _center = LatLng(OrderModelController.currentPosition!.latitude,
      OrderModelController.currentPosition!.longitude);
  List<LatLng> latLen = [];
  final MapType _currentMapType = MapType.normal;

  List<String> images = [
    'assets/images/driver_logo.png',
    'assets/images/marker.png',
  ];
  final Key _mapKey = UniqueKey();

  final LocationSettings locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      intervalDuration: const Duration(seconds: 1));

  var source = ValueNotifier<Position>(Position(
      longitude: OrderModelController.currentPosition!.longitude,
      latitude: OrderModelController.currentPosition!.latitude,
      timestamp: null,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0));

  GoogleMapController? _controller;
  LatLng? sourceDestination;

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

  /// Makers making functionality
  makeMarkers() async {
    Uint8List? driver = await getBytesFromAssets(images[0]);
    Uint8List? image = await getBytesFromAssets(
      images[1],
    );

    markers = List.generate(latLen.length, (index) {
      int nIndex = index;
      final updateIndex = --nIndex;

      return Marker(
          icon: index == 0
              ? BitmapDescriptor.fromBytes(driver)
              : BitmapDescriptor.fromBytes(image),
          markerId: index == 0
              ? const MarkerId('0')
              : MarkerId(OrderModelController
                  .pickedOrdersModel.data[updateIndex].id
                  .toString()),
          position: latLen[index],
          onTap: index == 0
              ? null
              : () {
                  customInfoWindowController.addInfoWindow!(
                    Container(
                      height: 40.sp,
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
                                      "Priority".tr(),
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
                                    onTap: () {
                                      customInfoWindowController
                                          .hideInfoWindow!();
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 12.sp,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
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
                              controller: markerController[updateIndex],
                              onChanged: (value) {},
                              onSubmitted: (val) async {
                                if (int.parse(val) < latLen.length) {
                                  updatePriorityList[updateIndex] =
                                      PickOrderModel(
                                          orderId: OrderModelController
                                              .pickedOrdersModel
                                              .data[updateIndex]
                                              .id
                                              .toString(),
                                          priority: val);
                                  setState(() {});

                                  customInfoWindowController.hideInfoWindow!();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "${"priority should be less than".tr()} ${latLen.length}")));
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

  /// make polylines functionality

  void makePolyline(polylines) {
    _polyline = Polyline(
        polylineId: PolylineId(latLen[0].longitude.toString()),
        color: Colors.green,
        width: 5,
        points: polylines);

    print("Polyline is $_polyline");
  }

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
    customInfoWindowController.onCameraMove!();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller; // simple googlemap controller

    customInfoWindowController.googleMapController = controller;
  }

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  /// Get user current position
  getPosition() async {
    latLen.clear();
    if (OrderModelController.currentPosition == null) {
      await _determinePosition();
      sourceDestination = LatLng(source.value.latitude, source.value.longitude);
      latLen.add(sourceDestination!);
      setState(() {});

      for (int i = 0;
          i < OrderModelController.pickedOrdersModel.data.length;
          i++) {
        final coordinates = OrderModelController
            .pickedOrdersModel.data[i].address.latLang!
            .split(",");
        latLen.add(
            LatLng(double.parse(coordinates[0]), double.parse(coordinates[1])));

        markerController.add(TextEditingController(
            text: OrderModelController
                .pickedOrdersModel.data[i].deliveryBoyPriority
                .toString()));

        updatePriorityList.add(
          PickOrderModel(
              orderId:
                  OrderModelController.pickedOrdersModel.data[i].id.toString(),
              priority: OrderModelController
                  .pickedOrdersModel.data[i].deliveryBoyPriority
                  .toString()),
        );
        setState(() {});
      }
    } else {
      sourceDestination = LatLng(OrderModelController.currentPosition!.latitude,
          OrderModelController.currentPosition!.longitude);
      latLen.add(sourceDestination!);
      setState(() {});

      for (int i = 0;
          i < OrderModelController.pickedOrdersModel.data.length;
          i++) {
        final coordinates = OrderModelController
            .pickedOrdersModel.data[i].address.latLang!
            .split(",");
        latLen.add(
            LatLng(double.parse(coordinates[0]), double.parse(coordinates[1])));
        markerController.add(TextEditingController(
            text: OrderModelController
                .pickedOrdersModel.data[i].deliveryBoyPriority
                .toString()));
        updatePriorityList.add(
          PickOrderModel(
              orderId:
                  OrderModelController.pickedOrdersModel.data[i].id.toString(),
              priority: OrderModelController
                  .pickedOrdersModel.data[i].deliveryBoyPriority
                  .toString()),
        );
        setState(() {});
      }
    }

    await makeMarkers();
    await getDirections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// Priority sets state
        bottomNavigationBar: BlocListener<PickOrdersCubit, PickOrdersState>(
          listener: (context, state) {
            if (state is PickOrdersLoaded) {
              OrderModelController.pickedOrdersModel.data.clear();
              OrderModelController.pickedDistance.clear();
              OrderModelController.pickedKmDistance.clear();

              widget.controller.jumpToPage(2);
              BlocProvider.of<OrderStatus>(context).changeStatus(2);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AssignedAndPickedOrders(
                            pageValue: 2,
                          )),
                  (Route<dynamic> route) => false);
              flutterSnackBar(
                context,
                state.message.tr(),
              );
            }
            if (state is PickOrdersException) {
              flutterSnackBar(
                context,
                state.message,
              );
            }
            if (state is PickOrdersSocketException) {
              flutterSnackBar(
                context,
                "Please check your internet connection".tr(),
              );
            }
          },
          child: BlocListener<UpdatePriorityCubit, UpdatePriorityState>(
            listener: (context, state) {
              if (state is UpdatePriorityFailed) {
                Navigator.pop(context);
                flutterSnackBar(
                  context,
                  "Priority not set successfully".tr(),
                );
              }
              if (state is UpdatePrioritySuccess) {
                BlocProvider.of<PickOrdersCubit>(context)
                    .pickOrders(pickOrderModel: updatePriorityList);

                flutterSnackBar(
                  context,
                  "Priority set successfully".tr(),
                );
              }
              if (state is UpdatePrioritySocketException) {
                flutterSnackBar(
                  context,
                  "Please check your internet connection".tr(),
                );
              }
            },
            child: BlocBuilder<UpdatePriorityCubit, UpdatePriorityState>(
              builder: (context, state) {
                if (state is UpdatePriorityLoading) {
                  return loadingIndicator();
                }
                return ReachedButtonWidget(
                  title: "Continue Delivery".tr(),
                  onTap: () {
                    BlocProvider.of<UpdatePriorityCubit>(context)
                        .pickOrders(pickOrderModel: updatePriorityList);
                  },
                  buttonColor: AppColors.primaryColor,
                );
              },
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              indoorViewEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onTap: (position) {
                customInfoWindowController.hideInfoWindow!();
              },
              compassEnabled: false,
              key: _mapKey,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: Set.from(markers),
              onCameraMove: _onCameraMove,
              polylines: {_polyline!},
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
            CustomInfoWindow(
              controller: customInfoWindowController,
            ),
          ],
        ));
  }

  /// determine user current position
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
        return Future.error("Location permissions are denied".tr());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, we cannot request permissions."
              .tr());
    }

    source.value = await Geolocator.getCurrentPosition();
  }

  /// get user direction api and make polyline

  getDirections() async {
    String apiKey = TojjarKeys.googleMapKey;
    String origin =
        '${latLen[0].latitude}, ${latLen[0].longitude}'; // Replace with the starting location
    String destination =
        '${latLen[latLen.length - 1].latitude}, ${latLen[latLen.length - 1].longitude}'; // Replace with the destination location
    String wayPoints = '';
    for (var i = 0; i < latLen.length; i++) {
      wayPoints += '${latLen[i].latitude}, ${latLen[i].longitude}|';
    }

    String driveMode = 'driving';
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&waypoints=$wayPoints&mode=$driveMode&key=$apiKey';

    // Make the HTTP request
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      /// Request successful
      try {
        var data = json.decode(response.body);

        if (data['status'] == 'OK') {
          var decodePoly = await decodePolyline(
              data['routes'][0]['overview_polyline']['points']);

          print("POLYLINES IS $decodePoly");
          _fitPolylineBounds(decodePoly);

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

  /// decode polyline

  Future<List<LatLng>> decodePolyline(String encodedPolyline) async {
    List<LatLng> polylinePoints = [];
    var list = PolylinePoints().decodePolyline(encodedPolyline);

    for (int i = 0; i < list.length; i++) {
      polylinePoints.add(LatLng(list[i].latitude, list[i].longitude));
      _controller!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: markers[0].position, zoom: 20)));
    }
    polylinePoints[0] = latLen[0];
    polylinePoints[polylinePoints.length - 1] = latLen[latLen.length - 1];

    return polylinePoints;
  }

  /// this function is used to fit polylines

  void _fitPolylineBounds(List<LatLng> points) {
    LatLngBounds bounds = LatLngBounds(
      southwest: points.reduce((value, element) => LatLng(
          value.latitude < element.latitude ? value.latitude : element.latitude,
          value.longitude < element.longitude
              ? value.longitude
              : element.longitude)),
      northeast: points.reduce((value, element) => LatLng(
          value.latitude > element.latitude ? value.latitude : element.latitude,
          value.longitude > element.longitude
              ? value.longitude
              : element.longitude)),
    );

    _controller!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }
}
