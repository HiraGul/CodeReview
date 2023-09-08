import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/order_detail_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';

class OrderDetailsRepository {
  static Future<int> orderDetails({
    required String orderId,
  }) async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    OrderDetailsController.orderDetailModel.data.orderDetails?.clear();

    try {
      var headers = {
        'Authorization': 'Bearer ${loginModel!.accessToken}',
      };
      var request = http.Request(
          'GET', Uri.parse('${BaseUrl.baseUrlDeliveryBoy}orders/$orderId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        OrderDetailsController.orderDetailModel =
            orderDetailModelFromJson(data);
        OrderDetailsController.orderDetailModelCopy =
            orderDetailModelFromJson(data);

        return response.statusCode;
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
