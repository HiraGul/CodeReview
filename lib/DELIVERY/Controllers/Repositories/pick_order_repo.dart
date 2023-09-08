import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/api_response_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/api_response_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/pick_order_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';

class PickOrderRepo {
  static Future<int> pickOrders(
      {required List<PickOrderModel> pickOrderModel}) async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var headers = {
        'Authorization': 'Bearer ${loginModel!.accessToken}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      Map data = {"orders": pickOrderModel};
      print(jsonEncode(data));
      final response = await http.put(
          Uri.parse(
            '${BaseUrl.baseUrlDeliveryBoy}orders/picked',
          ),
          headers: headers,
          body: jsonEncode(data));
      print(response.body.toString());
      print("ERRRRR");

      if (response.statusCode == 200) {
        ApiResponseController.apiResponseModel =
            apiResponseModelFromJson(response.body.toString());
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
