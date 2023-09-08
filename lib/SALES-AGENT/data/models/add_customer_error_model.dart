// To parse this JSON data, do
//
//     final addCustomerErrorModel = addCustomerErrorModelFromJson(jsonString);

import 'dart:convert';

AddCustomerErrorModel addCustomerErrorModelFromJson(String str) =>
    AddCustomerErrorModel.fromJson(json.decode(str));

String addCustomerErrorModelToJson(AddCustomerErrorModel data) =>
    json.encode(data.toJson());

class AddCustomerErrorModel {
  final int? status;
  final List<String>? errors;

  AddCustomerErrorModel({
    this.status,
    this.errors,
  });

  factory AddCustomerErrorModel.fromJson(Map<String, dynamic> json) =>
      AddCustomerErrorModel(
        status: json["status"],
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errors":
            errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
      };
}
