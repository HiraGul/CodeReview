// To parse this JSON data, do
//
//     final partialPaymentModel = partialPaymentModelFromJson(jsonString);

import 'dart:convert';

PartialPaymentModel partialPaymentModelFromJson(String str) =>
    PartialPaymentModel.fromJson(json.decode(str));

String partialPaymentModelToJson(PartialPaymentModel data) =>
    json.encode(data.toJson());

class PartialPaymentModel {
  final Data data;
  final bool success;
  final String message;

  PartialPaymentModel({
    required this.data,
    required this.success,
    required this.message,
  });

  factory PartialPaymentModel.fromJson(Map<String, dynamic> json) =>
      PartialPaymentModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "success": success,
        "message": message,
      };
}

class Data {
  final int deliveryBoyId;
  final String orderId;
  final int saleAgentId;
  final DateTime requestTime;
  final String orderAmount;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Data({
    required this.deliveryBoyId,
    required this.orderId,
    required this.saleAgentId,
    required this.requestTime,
    required this.orderAmount,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deliveryBoyId: json["delivery_boy_id"],
        orderId: json["order_id"],
        saleAgentId: json["sale_agent_id"],
        requestTime: DateTime.parse(json["request_time"]),
        orderAmount: json["order_amount"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "delivery_boy_id": deliveryBoyId,
        "order_id": orderId,
        "sale_agent_id": saleAgentId,
        "request_time": requestTime.toIso8601String(),
        "order_amount": orderAmount,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
