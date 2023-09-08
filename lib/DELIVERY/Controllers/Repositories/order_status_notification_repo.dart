import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

import '../../Utils/api_status_code.dart';

class OrderStatusNotificationRepo {
  static Future<int> orderStatusNotification(
      {required String customerId, required String status}) async {
    var topic = 'Customer-$customerId';

    try {
      var headers = {
        'Authorization':
            'Key=AAAAPbNCzIo:APA91bH5j9Qtgp7Pw8D4OZYN7p4VQ1Nzbs_Fnyuwv8GIkTZVsSTg8AcnJjqXgH9uvjDExMq1nDk9LiFn_aDSQkYIWjSGIY7hLen-PXdhKHTKupud26xpNVfujkKDva9_Z8Jt7JK7IoJg',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));

      request.body = json.encode({
        "to": "/topics/$topic",
        "notification": {
          "title": "Order Status",
          "body": "Your Order has been $status".tr()
        },
        "data": {"route": "/payLaterRequest"}
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
