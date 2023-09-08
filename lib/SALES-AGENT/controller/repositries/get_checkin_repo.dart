import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

import '../../../DELIVERY/Data/Models/login_model.dart';
import '../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../../DELIVERY/Utils/baseurl.dart';
import '../../data/dataController/data_controller.dart';
import '../../data/models/checkin_model.dart';
import '../../data/models/get_checkin_model.dart';

class GetCheckInRepo {
  Future<int> getGetCheckInData() async {
    LoginModel? loginModel = MySharedPrefs.getUser();
    CheckInModel? checkInModel = MySharedPrefs.getCheckInData();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${loginModel!.accessToken}'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '${BaseUrl.baseUrl}sale-agent/checkedIn?visit_id=${checkInModel!.data!.id}'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        getCheckInModelController =
            getCheckInModelFromJson(await response.stream.bytesToString());
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
