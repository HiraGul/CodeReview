import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/create_pay_later_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/create_pay_request_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';

import '../../Utils/app_sharedPrefs.dart';

class PayLaterRepo {
  static dynamic payLetterStatus = 'null';
  static Future<int> requestPayLater({required String orderId}) async {
    try {
      var user = MySharedPrefs.getUser();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user?.accessToken}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var request = http.Request('POST',
          Uri.parse('${BaseUrl.baseUrl}delivery-boy/orders/pay-later-request'));
      request.bodyFields = {'order_id': orderId};
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        CreatePayLaterController.createPayRequestModel =
            createPayRequestModelFromJson(
                await response.stream.bytesToString());
      }

      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }

  static Future<int> checkPayLater({required String orderId}) async {
    print("Order Id $orderId");
    payLetterStatus = 'null';

    var user = MySharedPrefs.getUser();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user?.accessToken}'
      };
      var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '${BaseUrl.baseUrl}delivery-boy/orders/pay-later-request/$orderId/check'),
      );
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var body = json.decode(await response.stream.bytesToString());

        if (body['success']) {
          payLetterStatus = body['data']['status'];

          return response.statusCode;
        } else {
          throw Exception(body['message']);
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
