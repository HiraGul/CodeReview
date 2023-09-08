// To parse this JSON data, do
//
//     final apiResponseModel = apiResponseModelFromJson(jsonString);

import 'dart:convert';

ApiResponseModel apiResponseModelFromJson(String str) =>
    ApiResponseModel.fromJson(json.decode(str));

String apiResponseModelToJson(ApiResponseModel data) =>
    json.encode(data.toJson());

class ApiResponseModel {
  String message;
  bool success;

  ApiResponseModel({
    required this.message,
    required this.success,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) =>
      ApiResponseModel(
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
      };
}
