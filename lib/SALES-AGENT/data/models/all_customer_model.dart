// To parse this JSON data, do
//
//     final allCustomerModel = allCustomerModelFromJson(jsonString);

import 'dart:convert';

AllCustomerModel allCustomerModelFromJson(String str) =>
    AllCustomerModel.fromJson(json.decode(str));

String allCustomerModelToJson(AllCustomerModel data) =>
    json.encode(data.toJson());

class AllCustomerModel {
  final String? message;
  final List<Customer>? customers;

  AllCustomerModel({
    this.message,
    this.customers,
  });

  factory AllCustomerModel.fromJson(Map<String, dynamic> json) =>
      AllCustomerModel(
        message: json["message"],
        customers: json["customers"] == null
            ? []
            : List<Customer>.from(
                json["customers"]!.map((x) => Customer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "customers": customers == null
            ? []
            : List<dynamic>.from(customers!.map((x) => x.toJson())),
      };
}

class Customer {
  final int? userId;
  final String? name;
  final String? shopName;
  final String? phone;

  Customer({
    this.userId,
    this.name,
    this.shopName,
    this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        userId: json["user_id"],
        name: json["name"],
        shopName: json["shop_name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "shop_name": shopName,
        "phone": phone,
      };
}
