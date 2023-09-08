import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/models/target_and_achievements_model.dart';

import '../../../DELIVERY/Data/Models/login_model.dart';
import '../../../DELIVERY/Utils/api_status_code.dart';
import '../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../../DELIVERY/Utils/baseurl.dart';

class TargetAndAchievementsRepo {
  Future<int> getTargetAchievementsData() async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${loginModel!.accessToken}'
      };
      var request = http.Request(
          'GET', Uri.parse('${BaseUrl.baseUrl}sale-agent/targets'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        targetAndAchievementsModelController =
            targetAndAchievementsModelFromJson(
                await response.stream.bytesToString());
        if (targetAndAchievementsModelController!.data == null) {
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
