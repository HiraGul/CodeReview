import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../DELIVERY/Utils/api_status_code.dart';

class TimeDistanceRepo {
  Future getTimedistance(endDistination, source) async {
    try {
      var response = await http.get(Uri.parse(
          "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${endDistination.latitude},${endDistination.longitude}&origins=${source.value.latitude},${source.value.longitude}&key=AIzaSyAWmPl-hWW9bxKhB0PB_8RGxS_ZZrtqEtM"));
      if (response.statusCode == 200) {
        var decode = await json.decode(response.body);
        var totalDistance =
            decode['rows'][0]['elements'][0]['distance']['text'];
        var totalTime = decode['rows'][0]['elements'][0]['duration']['text'];
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
