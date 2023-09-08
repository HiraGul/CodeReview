// To parse this JSON data, do
//
//     final checkInErrorModel = checkInErrorModelFromJson(jsonString);

import 'dart:convert';

CheckInErrorModel checkInErrorModelFromJson(String str) =>
    CheckInErrorModel.fromJson(json.decode(str));

String checkInErrorModelToJson(CheckInErrorModel data) =>
    json.encode(data.toJson());

class CheckInErrorModel {
  final dynamic data;
  final String? message;
  final bool? status;

  CheckInErrorModel({
    this.data,
    this.message,
    this.status,
  });

  factory CheckInErrorModel.fromJson(Map<String, dynamic> json) =>
      CheckInErrorModel(
        data: json["data"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "status": status,
      };
}
