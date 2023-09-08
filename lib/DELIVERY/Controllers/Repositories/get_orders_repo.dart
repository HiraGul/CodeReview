import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/distance_time_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/assigned_orders_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/delivery_started_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/distance_time_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/keys.dart';

import '../../Utils/app_sharedPrefs.dart';

class GetOrdersRepo {
  static Future<int> getAllOrders() async {
    OrderModelController.allOrders.data.clear();
    OrderModelController.assignedOrdersModel.data.clear();
    OrderModelController.distance.clear();
    OrderModelController.kmDistance.clear();
    OrderModelController.startedDeliveries.data.clear();
    OrderModelController.deliveryStartedDistance.clear();
    OrderModelController.deliveryStartedKmDistance.clear();
    OrderModelController.pickedOrdersModel.data.clear();
    OrderModelController.pickedDistance.clear();
    OrderModelController.pickedKmDistance.clear();

    try {
      LoginModel? loginModel = MySharedPrefs.getUser();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${loginModel!.accessToken}',
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://tojjar-backend.jmmtest.com/api/v2/delivery-boy/orders'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        OrderModelController.allOrders.data.clear();
        OrderModelController.assignedOrdersModel.data.clear();
        OrderModelController.startedDeliveries.data.clear();
        OrderModelController.allOrders =
            assignedOrderModelFromJson(await response.stream.bytesToString());

        for (int i = 0; i < OrderModelController.allOrders.data.length; i++) {
          if (OrderModelController.allOrders.data[i].deliveryStatus ==
              'picked_up') {
            OrderModelController.startedDeliveries.data
                .add(OrderModelController.allOrders.data[i]);
          } else {
            OrderModelController.assignedOrdersModel.data
                .add(OrderModelController.allOrders.data[i]);
          }

          final status = await calculateDistance(
            OrderModelController.allOrders.data[i].address.latLang!,
            OrderModelController.allOrders.data[i].deliveryStatus,
            OrderModelController.allOrders.data[i].deliveryBoyPriority ?? 0,
          );

          if (status != 200) {
            return status;
          }
        }
      }
      var set = OrderModelController.assignedOrdersModel.data.toSet();

      OrderModelController.assignedOrdersModel.data = set.toList();
      sortList();
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } on Exception {
      return ApiStatusCode.badRequest;
    }
  }
}

Future<int> calculateDistance(
    String latLan, String orderTyp, int priority) async {
  String apiKey = TojjarKeys.googleMapKey;
  double endLongitude;
  double endLatitude;
  final coordinates = latLan.split(',');
  endLatitude = double.parse(coordinates[0]);
  endLongitude = double.parse(coordinates[1]);

  final startLatitude = OrderModelController.currentPosition?.latitude;
  final startLongitude = OrderModelController.currentPosition?.longitude;

  String url =
      "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&key=$apiKey";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    DistanceTimeController.distanceTimeModel =
        distanceTimeModelFromJson(response.body);
  }
  if (orderTyp == 'picked_up') {
    if (DistanceTimeController
            .distanceTimeModel!.rows![0].elements![0].status ==
        'ZERO_RESULTS') {
      OrderModelController.deliveryStartedKmDistance
          .add(DeliveryStartedModel(priority: priority, distance: '0 mi '));
      OrderModelController.deliveryStartedDistance
          .add(DeliveryStartedModel(priority: priority, distance: '0 min'));
    } else {
      OrderModelController.deliveryStartedKmDistance.add(DeliveryStartedModel(
          priority: priority,
          distance: DistanceTimeController
              .distanceTimeModel!.rows![0].elements![0].distance!.text!));
      OrderModelController.deliveryStartedDistance.add(DeliveryStartedModel(
          priority: priority,
          distance: DistanceTimeController
              .distanceTimeModel!.rows![0].elements![0].duration!.text!));
    }
  } else {
    if (DistanceTimeController
            .distanceTimeModel!.rows![0].elements![0].status ==
        'ZERO_RESULTS') {
      OrderModelController.kmDistance.add('0 mi');
      OrderModelController.distance.add('0 min');
    } else {
      OrderModelController.kmDistance.add(DistanceTimeController
          .distanceTimeModel!.rows![0].elements![0].distance!.text!);
      OrderModelController.distance.add(DistanceTimeController
          .distanceTimeModel!.rows![0].elements![0].duration!.text!);
    }
  }
  return response.statusCode;
}

sortList() {
  OrderModelController.startedDeliveries.data.sort((a, b) =>
      a.deliveryBoyPriority!.compareTo(b.deliveryBoyPriority!.toInt()));
  OrderModelController.deliveryStartedKmDistance
      .sort((a, b) => a.priority.compareTo(b.priority));
  OrderModelController.deliveryStartedDistance
      .sort((a, b) => a.priority.compareTo(b.priority));

  var set = OrderModelController.startedDeliveries.data.toSet();

  OrderModelController.startedDeliveries.data = set.toList();
}

// calculateDistance(String latLan, String orderTyp, int priority) async {
//   double endLongitude;
//   double endLatitude;
//   final coordinates = latLan.split(',');
//   endLatitude = double.parse(coordinates[0]);
//   endLongitude = double.parse(coordinates[1]);
//
//   final startLatitude = OrderModelController.currentPosition!.latitude;
//   final startLongitude = OrderModelController.currentPosition!.longitude;
//
//   final distance = Geolocator.distanceBetween(
//     endLatitude,
//     endLongitude,
//     startLatitude,
//     startLongitude,
//   );
//   final distanceInKm = distance / 1000;
//   final time = distance / 120;
//   String url =
//       "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=40.6655101,-73.89188969999998&destinations=40.6905615%2C,-73.9976592&key=YOUR_API_KEY";
//
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     print(response.body);
//     print('Time is this');
//   }
//   if (orderTyp == 'picked_up') {
//     OrderModelController.deliveryStartedKmDistance
//         .add(DeliveryStartedModel(priority: priority, distance: distance));
//     OrderModelController.deliveryStartedDistance
//         .add(DeliveryStartedModel(priority: priority, distance: time));
//   } else {
//     OrderModelController.kmDistance.add(distanceInKm);
//     OrderModelController.distance.add(time);
//   }
// }
//
