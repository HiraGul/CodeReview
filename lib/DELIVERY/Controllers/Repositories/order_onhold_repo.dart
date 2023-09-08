import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/api_response_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/api_response_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';

class OrderOnHoldRepository {
  static Future<int> orderOnHold(
      {required String orderId, required String date}) async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var headers = {
        'Authorization': 'Bearer ${loginModel!.accessToken}',
      };
      var request = http.Request(
          'PUT', Uri.parse('${BaseUrl.baseUrlDeliveryBoy}orders/on-hold'));

      request.bodyFields = {'order_id': orderId, 'date': date};

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      ApiResponseController.apiResponseModel =
          apiResponseModelFromJson(await response.stream.bytesToString());
      print(ApiResponseController.apiResponseModel?.message);
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
