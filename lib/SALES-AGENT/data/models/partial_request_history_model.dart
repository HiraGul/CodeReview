// To parse this JSON data, do
//
//     final partialRequestHistoryModel = partialRequestHistoryModelFromJson(jsonString);

import 'dart:convert';

PartialRequestHistoryModel partialRequestHistoryModelFromJson(String str) =>
    PartialRequestHistoryModel.fromJson(json.decode(str));

String partialRequestHistoryModelToJson(PartialRequestHistoryModel data) =>
    json.encode(data.toJson());

class PartialRequestHistoryModel {
  final String? message;
  final List<Order>? orders;

  PartialRequestHistoryModel({
    this.message,
    this.orders,
  });

  factory PartialRequestHistoryModel.fromJson(Map<String, dynamic> json) =>
      PartialRequestHistoryModel(
        message: json["message"],
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  final int? id;
  final String? driverName;
  final String? shopName;
  final int? orderItems;
  final dynamic amountToPay;
  final String? requestDate;
  final int? status;

  Order({
    this.id,
    this.driverName,
    this.shopName,
    this.orderItems,
    this.amountToPay,
    this.requestDate,
    this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        driverName: json["driver_name"],
        shopName: json["shop_name"],
        orderItems: json["order_items"],
        amountToPay: json["amount_to_pay"],
        requestDate: json["request_date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driver_name": driverName,
        "shop_name": shopName,
        "order_items": orderItems,
        "amount_to_pay": amountToPay,
        "request_date": requestDate,
        "status": status,
      };
}
