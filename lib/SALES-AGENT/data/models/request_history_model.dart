// To parse this JSON data, do
//
//     final requestHistoryModel = requestHistoryModelFromJson(jsonString);

import 'dart:convert';

RequestHistoryModel requestHistoryModelFromJson(String str) => RequestHistoryModel.fromJson(json.decode(str));

String requestHistoryModelToJson(RequestHistoryModel data) => json.encode(data.toJson());

class RequestHistoryModel {
    final String? message;
    final List<Order>? orders;

    RequestHistoryModel({
        this.message,
        this.orders,
    });

    factory RequestHistoryModel.fromJson(Map<String, dynamic> json) => RequestHistoryModel(
        message: json["message"],
        orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
    };
}

class Order {
    final int? id;
    final dynamic driverName;
    final String? shopName;
    final int? orderItems;
    final double? amountToPay;
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
        amountToPay: json["amount_to_pay"]?.toDouble(),
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
