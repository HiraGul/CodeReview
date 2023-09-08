import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../DELIVERY/Data/Models/login_model.dart';
import '../../../DELIVERY/Utils/api_status_code.dart';
import '../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../../DELIVERY/Utils/baseurl.dart';
import '../../data/dataController/data_controller.dart';
import '../../data/models/dashboard_model.dart';

class AgentDashboardRepo {
  Future<int> getDashboardData() async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${loginModel!.accessToken}'
      };
      var request = http.Request(
          'GET', Uri.parse('${BaseUrl.baseUrl}sale-agent/dashboard'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dashboardModelController =
            dashboardModelFromJson(await response.stream.bytesToString());
      }
      print(response.statusCode);
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      print(e);
      return ApiStatusCode.badRequest;
    }
  }
}
