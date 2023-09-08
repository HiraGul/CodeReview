import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/login_controllers.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';

import '../../Utils/baseurl.dart';

class TojjarLoginRepo {
  Future<int> tujjarLoginUser() async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${BaseUrl.baseUrl}auth/login'));

    request.fields.addAll({
      'email_or_phone': AuthControllers.phoneNumberController.text,
      'password': AuthControllers.passwordController.text,
      'user_type': AuthControllers.userType.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      AuthControllers.loginModelController =
          loginModelFromJson(await response.stream.bytesToString());
    }
    return response.statusCode;
  }
}
