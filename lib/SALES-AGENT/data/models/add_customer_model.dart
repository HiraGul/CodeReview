// To parse this JSON data, do
//
//     final addCustomerModel = addCustomerModelFromJson(jsonString);

import 'dart:convert';

AddCustomerModel addCustomerModelFromJson(String str) =>
    AddCustomerModel.fromJson(json.decode(str));

String addCustomerModelToJson(AddCustomerModel data) =>
    json.encode(data.toJson());

class AddCustomerModel {
  final bool? result;
  final String? message;
  final int? userId;

  AddCustomerModel({
    this.result,
    this.message,
    this.userId,
  });

  factory AddCustomerModel.fromJson(Map<String, dynamic> json) =>
      AddCustomerModel(
        result: json["result"],
        message: json["message"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "user_id": userId,
      };
}
