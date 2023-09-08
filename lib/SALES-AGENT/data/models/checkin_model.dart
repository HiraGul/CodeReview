// To parse this JSON data, do
//
//     final checkInModel = checkInModelFromJson(jsonString);

import 'dart:convert';

CheckInModel checkInModelFromJson(String str) =>
    CheckInModel.fromJson(json.decode(str));

String checkInModelToJson(CheckInModel data) => json.encode(data.toJson());

class CheckInModel {
  final Data? data;
  final String? message;
  final bool? status;

  CheckInModel({
    this.data,
    this.message,
    this.status,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "status": status,
      };
}

class Data {
  final int? saleAgentId;
  final String? checkIn;
  final String? checkInLocation;
  final int? customerId;
  final int? addressId;
  final String? shopName;
  final String? customerName;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Data({
    this.saleAgentId,
    this.checkIn,
    this.checkInLocation,
    this.customerId,
    this.addressId,
    this.shopName,
    this.customerName,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        saleAgentId: json["sale_agent_id"],
        checkIn: json["check_in"],
        checkInLocation: json["check_in_location"],
        customerId: json["customer_id"],
        addressId: json["address_id"],
        shopName: json["shop_name"],
        customerName: json["customer_name"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "sale_agent_id": saleAgentId,
        "check_in": checkIn,
        "check_in_location": checkInLocation,
        "customer_id": customerId,
        "address_id": addressId,
        "shop_name": shopName,
        "customer_name": customerName,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
