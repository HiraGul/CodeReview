import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';

import '../../../DELIVERY/Data/Models/login_model.dart';
import '../../../DELIVERY/Utils/api_status_code.dart';
import '../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../data/dataController/data_controller.dart';

class LoginAsCustomerRepo {
  static Future<int> getLoginAsCustomerData(customerId) async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${loginModel!.accessToken}'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${BaseUrl.baseUrl}sale-agent/login-as-customer'));
      request.fields.addAll({'customerId': "$customerId"});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        loginCustomerController =
            loginModelFromJson(await response.stream.bytesToString());
        // loginCustomerController = model.accessToken;
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
