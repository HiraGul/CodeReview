import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/partial_payment_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/partial_payment_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/baseurl.dart';

import '../../Utils/app_sharedPrefs.dart';

class PartialPaymentRepo {
  static dynamic partialStatus = 'null';
  static Future<int> createPartialPaymentRequest(
      {required String orderId, required String orderAmount}) async {
    try {
      var user = MySharedPrefs.getUser();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user?.accessToken}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              '${BaseUrl.baseUrl}delivery-boy/orders/partial-payment-request'));
      request.bodyFields = {'order_id': orderId, 'order_amount': orderAmount};
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        PartialPaymentController.partialPaymentModel =
            partialPaymentModelFromJson(await response.stream.bytesToString());
      }

      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } on Exception {
      return ApiStatusCode.badRequest;
    }
  }

  static Future<int> checkPartialPaymentRequest(
      {required String orderId}) async {
    partialStatus = 'null';
    var user = MySharedPrefs.getUser();

    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user?.accessToken}'
      };
      var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '${BaseUrl.baseUrl}delivery-boy/orders/partial-payment-request/$orderId/check'),
      );
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var body = json.decode(await response.stream.bytesToString());
        print("Body $body");

        if (body['success']) {
          partialStatus = body['data']['status'];

          debugPrint("Partial Payment Repo status $partialStatus");

          return response.statusCode;
        } else {
          throw Exception(body['message']);
        }
      } else {
        return response.statusCode;
      }
    } on SocketException {
      return ApiStatusCode.socketException;
    } on Exception {
      return ApiStatusCode.badRequest;
    }
  }
}
