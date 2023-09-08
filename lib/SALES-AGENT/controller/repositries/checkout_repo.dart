import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/models/checkin_model.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/global_field_and_variable.dart';

import '../../../DELIVERY/Data/Models/login_model.dart';
import '../../../DELIVERY/Utils/api_status_code.dart';
import '../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../data/dataController/data_controller.dart';
import '../../data/models/checkout_model.dart';

class CheckOutRepo {
  Future<int> getCheckOutData(date, location) async {
    LoginModel? loginModel = MySharedPrefs.getUser();
    CheckInModel? checkInModel = MySharedPrefs.getCheckInData();

    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${loginModel!.accessToken}'
      };
      var request = http.Request(
          'POST', Uri.parse('${BaseUrl.baseUrl}sale-agent/checkout'));
      request.bodyFields = {
        'visit_id': "${checkInModel!.data!.id}",
        'check_out': date,
        'check_out_location': location,
        'reason': checkoutReason.text,
      };
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        checkOutModelController =
            checkOutModelFromJson(await response.stream.bytesToString());
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
