import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../DELIVERY/Data/Models/login_model.dart';
import '../../../DELIVERY/Utils/api_status_code.dart';
import '../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../../DELIVERY/Utils/baseurl.dart';
import '../../data/dataController/data_controller.dart';
import '../../data/models/state_list_model.dart';

class StateListRepo {
  Future<int> getStateList() async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var request = http.Request('GET', Uri.parse('${BaseUrl.baseUrl}states'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        stateListModelController =
            stateListModelFromJson(await response.stream.bytesToString());
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
