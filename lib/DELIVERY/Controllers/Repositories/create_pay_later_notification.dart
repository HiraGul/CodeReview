import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Utils/keys.dart';

import '../../Utils/api_status_code.dart';

class CreatePayLaterNotificationRepo {
  static Future<int> payLaterNotificationRepo(
      {required String saleAgentId}) async {
    var topic = 'PayLaterRequest-$saleAgentId';

    try {
      var headers = {
        'Authorization': 'Key=${TojjarKeys.fcmKey}',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));

      request.body = json.encode({
        "to": "/topics/$topic",
        "notification": {
          "title": "Pay Later Request",
          "body": "Pay later request has been created please update status",
        },
        "data": {
          "route": "/payLaterRequest",
          "item_type_id": "",
          "item_type": "",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }
}
