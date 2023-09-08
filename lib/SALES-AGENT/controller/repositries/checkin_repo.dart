import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/models/checkin_error_model.dart';

import '../../../DELIVERY/Data/Models/login_model.dart';
import '../../../DELIVERY/Utils/api_status_code.dart';
import '../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../data/dataController/data_controller.dart';
import '../../data/models/checkin_model.dart';
import '../cubits/getCheckInCubit/get_checkin_cubit.dart';

class CheckInRepo {
  Future<int> getCheckInData(
      BuildContext context, addressId, userId, date, location) async {
    LoginModel? loginModel = MySharedPrefs.getUser();

    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${loginModel!.accessToken}'
      };
      var request = http.Request(
          'POST', Uri.parse('${BaseUrl.baseUrl}sale-agent/checkin'));
      request.bodyFields = {
        'address_id': addressId.toString(),
        'customer_id': userId.toString(),
        'check_in': date,
        'check_in_location': location
      };
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        checkInModelController =
            checkInModelFromJson(await response.stream.bytesToString());
        MySharedPrefs.setCheckInData(checkInModelController!);

        context.read<GetCheckInCubit>().fetchGetCheckInData();
      }
      if (response.statusCode == 400) {
        checkInErrorModel =
            checkInErrorModelFromJson(await response.stream.bytesToString());
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
