import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../DELIVERY/Data/Models/login_model.dart';
import '../../../DELIVERY/Utils/api_status_code.dart';
import '../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../../DELIVERY/Utils/baseurl.dart';
import '../../data/dataController/data_controller.dart';
import '../../data/models/district_list_model.dart';

class DistrictListRepo {
  Future<int> getDistrictList() async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var request =
          http.Request('GET', Uri.parse('${BaseUrl.baseUrl}neighborhoods'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        districtListModelController =
            districtListModelFromJson(await response.stream.bytesToString());
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
