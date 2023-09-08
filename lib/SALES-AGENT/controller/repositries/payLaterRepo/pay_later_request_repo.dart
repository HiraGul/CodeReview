import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../DELIVERY/Data/Models/login_model.dart';
import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../../../DELIVERY/Utils/app_sharedPrefs.dart';

class PayLaterRequestRepo {
  Future<int> getPayLaterRequestData(requestId, hour) async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${loginModel!.accessToken}'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://tojjar-backend.jmmtest.com/api/v2/sale-agent/request/$requestId/update'));
      request.fields.addAll({'status': '1', 'allowed_time': '$hour'});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
      }

      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
