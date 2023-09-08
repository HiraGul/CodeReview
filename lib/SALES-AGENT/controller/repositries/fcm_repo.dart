import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Utils/keys.dart';

class FcmRepo {
  sendNotification(id, orderId, paymentRequest, title, message, route) async {
    try {
      var headers = {
        'Authorization': 'Key=${TojjarKeys.fcmKey}',
        "Content-Type": "application/json"
      };
      var request = http.Request(
          "POST", Uri.parse('https://fcm.googleapis.com/fcm/send'));
      request.body = jsonEncode({
        "to": "/topics/$paymentRequest-$id",
        "notification": {"title": "$title", "body": message},
        "data": {
          "route": "/$route",
          "item_type_id": orderId.toString(),
          "item_type": "",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {}
      return response.statusCode;
    } on SocketException {
      return 503;
    } catch (e) {
      return 400;
    }
  }
}
