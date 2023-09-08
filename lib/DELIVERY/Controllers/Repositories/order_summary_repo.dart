import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_summary_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/order_summary_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';

import '../../Utils/api_status_code.dart';

class OrderSummaryRepo {
  LoginModel? loginModel = MySharedPrefs.getUser();

  Future<int> getOrdersSummary() async {
    try {
      var headers = {
        'Authorization': 'Bearer ${loginModel!.accessToken}',
      };
      var request = http.Request(
          'GET', Uri.parse('${BaseUrl.baseUrlDeliveryBoy}orders-summary'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        orderSummaryModelController =
            orderSummaryModelFromJson(await response.stream.bytesToString());
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
