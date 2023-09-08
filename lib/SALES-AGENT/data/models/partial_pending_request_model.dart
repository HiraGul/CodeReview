// To parse this JSON data, do
//
//     final partialPendingRequestModel = partialPendingRequestModelFromJson(jsonString);

import 'dart:convert';

PartialPendingRequestModel partialPendingRequestModelFromJson(String str) =>
    PartialPendingRequestModel.fromJson(json.decode(str));

String partialPendingRequestModelToJson(PartialPendingRequestModel data) =>
    json.encode(data.toJson());

class PartialPendingRequestModel {
  final String? message;
  final List<Request>? requests;

  PartialPendingRequestModel({
    this.message,
    this.requests,
  });

  factory PartialPendingRequestModel.fromJson(Map<String, dynamic> json) =>
      PartialPendingRequestModel(
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
  final int? orderId;
  final String? driverName;
  final String? shopName;
  final int? orderItems;
  final dynamic amountToPay;
  final String? requestDate;
  final int? status;

  Request({
    this.id,
    this.orderId,
    this.driverName,
    this.shopName,
    this.orderItems,
    this.amountToPay,
    this.requestDate,
    this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        orderId: json["order_id"],
        driverName: json["driver_name"],
        shopName: json["shop_name"],
        orderItems: json["order_items"],
        amountToPay: json["amount_to_pay"],
        requestDate: json["request_date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "driver_name": driverName,
        "shop_name": shopName,
        "order_items": orderItems,
        "amount_to_pay": amountToPay,
        "request_date": requestDate,
        "status": status,
      };
}
