import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/models/partial_request_history_model.dart';

import '../../../../DELIVERY/Data/Models/login_model.dart';
import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../../../DELIVERY/Utils/app_sharedPrefs.dart';

class PartialRequestHistoryRepo {
  Future<int> getRequestHistoryData() async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${loginModel!.accessToken}'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '${BaseUrl.baseUrl}sale-agent/partial-payment/requests-history'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        partialRequestHistoryModelController =
            partialRequestHistoryModelFromJson(
                await response.stream.bytesToString());
        if (partialRequestHistoryModelController!.orders!.isEmpty) {
          return 00;
        }
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
