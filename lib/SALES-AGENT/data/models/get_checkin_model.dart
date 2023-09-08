// To parse this JSON data, do
//
//     final getCheckInModel = getCheckInModelFromJson(jsonString);

import 'dart:convert';

GetCheckInModel getCheckInModelFromJson(String str) =>
    GetCheckInModel.fromJson(json.decode(str));

String getCheckInModelToJson(GetCheckInModel data) =>
    json.encode(data.toJson());

class GetCheckInModel {
  final String? message;
  final Data? data;

  GetCheckInModel({
    this.message,
    this.data,
  });

  factory GetCheckInModel.fromJson(Map<String, dynamic> json) =>
      GetCheckInModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? visitId;
  final DateTime? checkedIn;
  final String? checkedInLocation;
  final String? shopName;

  Data({
    this.visitId,
    this.checkedIn,
    this.checkedInLocation,
    this.shopName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        visitId: json["visit_id"],
        checkedIn: json["checkedIn"] == null
            ? null
            : DateTime.parse(json["checkedIn"]),
        checkedInLocation: json["checkedInLocation"],
        shopName: json["shopName"],
      );

  Map<String, dynamic> toJson() => {
        "visit_id": visitId,
        "checkedIn": checkedIn?.toIso8601String(),
        "checkedInLocation": checkedInLocation,
        "shopName": shopName,
      };
}
