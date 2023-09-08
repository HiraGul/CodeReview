// To parse this JSON data, do
//
//     final pendingRequestModel = pendingRequestModelFromJson(jsonString);

import 'dart:convert';

PendingRequestModel pendingRequestModelFromJson(String str) =>
    PendingRequestModel.fromJson(json.decode(str));

String pendingRequestModelToJson(PendingRequestModel data) =>
    json.encode(data.toJson());

class PendingRequestModel {
  final String? message;
  final List<Request>? requests;

  PendingRequestModel({
    this.message,
    this.requests,
  });

  factory PendingRequestModel.fromJson(Map<String, dynamic> json) =>
      PendingRequestModel(
        message: json["message"],
        requests: json["requests"] == null
            ? []
            : List<Request>.from(
                json["requests"]!.map((x) => Request.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "requests": requests == null
            ? []
            : List<dynamic>.from(requests!.map((x) => x.toJson())),
      };
}

class Request {
  final int? id;
  final String? driverName;
  final String? shopName;
  final int? orderItems;
  final double? amountToPay;
  final String? requestDate;
  final int? orderId;
  final int? status;

  Request(
      {this.id,
      this.driverName,
      this.shopName,
      this.orderItems,
      this.amountToPay,
      this.requestDate,
      this.status,
      this.orderId});

  factory Request.fromJson(Map<String, dynamic> json) => Request(
      id: json["id"],
      driverName: json["driver_name"],
      shopName: json["shop_name"],
      orderItems: json["order_items"],
      amountToPay: json["amount_to_pay"]?.toDouble(),
      requestDate: json["request_date"],
      status: json["status"],
      orderId: json["order_id"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "driver_name": driverName,
        "shop_name": shopName,
        "order_items": orderItems,
        "amount_to_pay": amountToPay,
        "request_date": requestDate,
        "status": status,
        "order_id": orderId
      };
}
