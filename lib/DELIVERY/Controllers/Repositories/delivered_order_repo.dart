import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';

class DeliverOrderRepo {
  static var error = '';

  static Future<int> deliverOrderRepo(
      {required Map<String, dynamic> deliveryData, File? file}) async {
    var user = MySharedPrefs.getUser();
    String endPoint = 'partial_delivered';

    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user?.accessToken}'
      };

      if (OrderDetailsController
              .orderDetailModelCopy.data.orderDetails!.length ==
          OrderDetailsController.deliveredOrderList.length) {
        for (int i = 0;
            i < OrderDetailsController.deliveredOrderList.length;
            i++) {
          if (OrderDetailsController
                  .orderDetailModelCopy.data.orderDetails![i].quantity ==
              deliveryData['items'][i]['quantity']) {
            endPoint = 'delivered';
          } else {
            endPoint = 'partial_delivered';
            break;
          }
        }
      }

      var request = http.Request(
          'POST', Uri.parse('${BaseUrl.baseUrl}delivery-boy/orders/$endPoint'));
      request.body = json.encode(deliveryData);

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var body = json.decode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        if (body['success']) {
          return response.statusCode;
        } else {
          error = throw Exception(body['message']);
        }
      } else {
        return response.statusCode;
      }
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
