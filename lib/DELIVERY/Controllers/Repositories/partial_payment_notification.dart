import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/keys.dart';

class CreatePartialPaymentNotificationRepo {
  static Future<int> partialPaymentNotificationRepo(
      {required String saleAgentId}) async {
    var topic = 'PartialPaymentRequest-$saleAgentId';

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
          "title": "Partial Payment Request",
          "body":
              "Partial payment request has been created please update status",
        },
        "data": {
          "route": "/partialPayRequest",
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
