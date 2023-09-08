// To parse this JSON data, do
//
//     final checkOutModel = checkOutModelFromJson(jsonString);

import 'dart:convert';

CheckOutModel checkOutModelFromJson(String str) =>
    CheckOutModel.fromJson(json.decode(str));

String checkOutModelToJson(CheckOutModel data) => json.encode(data.toJson());

class CheckOutModel {
  final Data? data;
  final String? message;
  final bool? status;

  CheckOutModel({
    this.data,
    this.message,
    this.status,
  });

  factory CheckOutModel.fromJson(Map<String, dynamic> json) => CheckOutModel(
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
  final int? id;
  final int? saleAgentId;
  final int? addressId;
  final int? customerId;
  final String? shopName;
  final String? customerName;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? checkInLocation;
  final String? checkOutLocation;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.saleAgentId,
    this.addressId,
    this.customerId,
    this.shopName,
    this.customerName,
    this.checkIn,
    this.checkOut,
    this.checkInLocation,
    this.checkOutLocation,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        saleAgentId: json["sale_agent_id"],
        addressId: json["address_id"],
        customerId: json["customer_id"],
        shopName: json["shop_name"],
        customerName: json["customer_name"],
        checkIn:
            json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
        checkOut: json["check_out"] == null
            ? null
            : DateTime.parse(json["check_out"]),
        checkInLocation: json["check_in_location"],
        checkOutLocation: json["check_out_location"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sale_agent_id": saleAgentId,
        "address_id": addressId,
        "customer_id": customerId,
        "shop_name": shopName,
        "customer_name": customerName,
        "check_in": checkIn?.toIso8601String(),
        "check_out": checkOut?.toIso8601String(),
        "check_in_location": checkInLocation,
        "check_out_location": checkOutLocation,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
