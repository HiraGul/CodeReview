// To parse this JSON data, do
//
//     final orderSummaryModel = orderSummaryModelFromJson(jsonString);

import 'dart:convert';

OrderSummaryModel orderSummaryModelFromJson(String str) =>
    OrderSummaryModel.fromJson(json.decode(str));

String orderSummaryModelToJson(OrderSummaryModel data) =>
    json.encode(data.toJson());

class OrderSummaryModel {
  final Data data;
  final bool success;
  final int status;

  OrderSummaryModel({
    required this.data,
    required this.success,
    required this.status,
  });

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) =>
      OrderSummaryModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "success": success,
        "status": status,
      };
}

class Data {
  final int partialDelivered;
  final int delivered;
  final int cancelled;
  final int pickedUp;
  final int pending;
  final int onTheWay;
  final int rescheduled;
  final int onHold;
  final int revisit;

  Data({
    required this.partialDelivered,
    required this.delivered,
    required this.cancelled,
    required this.pickedUp,
    required this.pending,
    required this.onTheWay,
    required this.rescheduled,
    required this.onHold,
    required this.revisit,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        partialDelivered: json["partial_Delivered"],
        delivered: json["delivered"],
        cancelled: json["cancelled"],
        pickedUp: json["picked_up"],
        pending: json["pending"],
        onTheWay: json["on_the_way"],
        rescheduled: json["rescheduled"],
        onHold: json["on_hold"],
        revisit: json["revisit"],
      );

  Map<String, dynamic> toJson() => {
        "partial_Delivered": partialDelivered,
        "delivered": delivered,
        "cancelled": cancelled,
        "picked_up": pickedUp,
        "pending": pending,
        "on_the_way": onTheWay,
        "rescheduled": rescheduled,
        "on_hold": onHold,
        "revisit": revisit,
      };
}
