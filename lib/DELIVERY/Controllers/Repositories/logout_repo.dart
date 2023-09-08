import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/login_controllers.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/logout_model.dart';

import '../../Utils/api_status_code.dart';
import '../../Utils/app_sharedPrefs.dart';
import '../../Utils/baseurl.dart';

class TojjarLogoutRepo {
  Future<int> tujjarlogoutUser() async {
    LoginModel? loginModel = MySharedPrefs.getUser();
    try {
      var headers = {'Authorization': 'Bearer ${loginModel!.accessToken}'};
      var request =
          http.Request('GET', Uri.parse('${BaseUrl.baseUrl}auth/logout'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        AuthControllers.logoutModelController =
            logoutModelFromJson(await response.stream.bytesToString());
      }

      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
