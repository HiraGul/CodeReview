// To parse this JSON data, do
//
//     final allOrdersModel = allOrdersModelFromJson(jsonString);

import 'dart:convert';

AllOrderModel allOrdersModelFromJson(String str) =>
    AllOrderModel.fromJson(json.decode(str));

String allOrdersModelToJson(AllOrderModel data) => json.encode(data.toJson());

class AllOrderModel {
  final String? message;
  final List<Order>? orders;

  AllOrderModel({
    this.message,
    this.orders,
  });

  factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
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
  final int? userId;
  final String? customerName;
  final String? code;
  final String? placedDate;
  final double? total;
  final String? status;

  Order({
    this.id,
    this.userId,
    this.customerName,
    this.code,
    this.placedDate,
    this.total,
    this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        customerName: json["customer_name"],
        code: json["code"],
        placedDate: json["placed_date"],
        total: json["total"]?.toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "customer_name": customerName,
        "code": code,
        "placed_date": placedDate,
        "total": total,
        "status": status,
      };
}
