

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';


class ResetPasswordRepo{




  static Future <int> sendOtp({required String phoneNumber})async{
    try {
      var headers = {
        'Accept': 'application/json'
      };
      var request = http.MultipartRequest('POST', Uri.parse("${BaseUrl.baseUrl}auth/forget-password/send-OTP"));
      request.fields.addAll({
        'phone_number': phoneNumber
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data =   json.decode(await response.stream.bytesToString());
        if(data['result']){

          return response.statusCode;
        }else{

          throw Exception(data['message']);
        }
      }
      else {
        print(response.reasonPhrase);
        return response.statusCode;

      }
    } on Exception catch (e) {
      rethrow;
      // TODO
    }
  }




  static Future<int>  verifyOtp({required String otp})async{

    try {
      var headers = {
        'Cookie': 'XSRF-TOKEN=0DwWqwC43g7OX9AiY56ie2NnQocVSJa5vEzMpgQH; tojjar_session=5c7RjI0BWiPeQ9S8fNOkgyyUzw4KS0KF3CXXx7oR'
      };
      var request = http.MultipartRequest('POST', Uri.parse("${BaseUrl.baseUrl}auth/forget-password/confirm-OTP"));
      request.fields.addAll({
        'otp': otp
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var data =  json.decode(await response.stream.bytesToString());

        if(data['result']){
          return response.statusCode;
        }else {
          throw Exception(data['message']);
        }
      }
      else {
        print(response.reasonPhrase);
        return response.statusCode;
      }
    } on Exception catch (e) {
      rethrow;
      // TODO
    }
  }






  static  Future<int> resetPassword({required String otp, required String confirmPassword})async{
    try {
      var headers = {
        'Cookie': 'XSRF-TOKEN=0DwWqwC43g7OX9AiY56ie2NnQocVSJa5vEzMpgQH; tojjar_session=5c7RjI0BWiPeQ9S8fNOkgyyUzw4KS0KF3CXXx7oR'
      };
      var request = http.MultipartRequest('POST', Uri.parse("${BaseUrl.baseUrl}auth/forget-password/reset-password"));
      request.fields.addAll({
        'otp': otp,
        'confirm_password': confirmPassword
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = json.decode(await response.stream.bytesToString());
        if(data['result']){

          return response.statusCode;
        }else{
          throw Exception(data['message']);
        }
      }
      else {
        print(response.reasonPhrase);
        return response.statusCode;
      }
    } on Exception catch (e) {
      rethrow;
      // TODO
    }

  }
}