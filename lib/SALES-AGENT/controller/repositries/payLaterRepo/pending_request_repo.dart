import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';

import '../../../../DELIVERY/Data/Models/login_model.dart';
import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../../data/dataController/data_controller.dart';
import '../../../data/models/pending_request_model.dart';

class PendingRequestRepo {
  Future<int> getPendingRequestData() async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${loginModel!.accessToken}'
      };
      var request = http.Request(
          'GET', Uri.parse('${BaseUrl.baseUrl}sale-agent/pending-requests'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        pendingRequestModelController =
            pendingRequestModelFromJson(await response.stream.bytesToString());
        if (pendingRequestModelController!.requests!.isEmpty) {
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
