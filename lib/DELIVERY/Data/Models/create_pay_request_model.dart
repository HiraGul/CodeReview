// To parse this JSON data, do
//
//     final createPayRequestModel = createPayRequestModelFromJson(jsonString);

import 'dart:convert';

CreatePayRequestModel createPayRequestModelFromJson(String str) =>
    CreatePayRequestModel.fromJson(json.decode(str));

String createPayRequestModelToJson(CreatePayRequestModel data) =>
    json.encode(data.toJson());

class CreatePayRequestModel {
  Data? data;
  bool? success;
  String? message;

  CreatePayRequestModel({
    this.data,
    this.success,
    this.message,
  });

  factory CreatePayRequestModel.fromJson(Map<String, dynamic> json) =>
      CreatePayRequestModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "success": success,
        "message": message,
      };
}

class Data {
  int? deliveryBoyId;
  String? orderId;
  int? saleAgentId;
  String? requestTime;
  double? orderAmount;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({
    this.deliveryBoyId,
    this.orderId,
    this.saleAgentId,
    this.requestTime,
    this.orderAmount,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        deliveryBoyId: json["delivery_boy_id"],
        orderId: json["order_id"],
        saleAgentId: json["sale_agent_id"],
        requestTime: json["request_time"],
        orderAmount: json["order_amount"].toDouble(),
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "delivery_boy_id": deliveryBoyId,
        "order_id": orderId,
        "sale_agent_id": saleAgentId,
        "request_time": requestTime,
        "order_amount": orderAmount,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}
