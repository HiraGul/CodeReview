// To parse this JSON data, do
//
//     final targetAndAchievementsModel = targetAndAchievementsModelFromJson(jsonString);

import 'dart:convert';

TargetAndAchievementsModel targetAndAchievementsModelFromJson(String str) =>
    TargetAndAchievementsModel.fromJson(json.decode(str));

String targetAndAchievementsModelToJson(TargetAndAchievementsModel data) =>
    json.encode(data.toJson());

class TargetAndAchievementsModel {
  final String? message;
  final Data? data;

  TargetAndAchievementsModel({
    this.message,
    this.data,
  });

  factory TargetAndAchievementsModel.fromJson(Map<String, dynamic> json) =>
      TargetAndAchievementsModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? totalDelivered;
  final dynamic totalEarnings;
  final int? totalRescheduled;
  final int? totalOnHold;
  final int? totalRevisited;
  final int? totalCancel;

  Data({
    this.totalDelivered,
    this.totalEarnings,
    this.totalRescheduled,
    this.totalOnHold,
    this.totalRevisited,
    this.totalCancel,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalDelivered: json["totalDelivered"],
        totalEarnings: json["totalEarnings"],
        totalRescheduled: json["totalRescheduled"],
        totalOnHold: json["totalOnHold"],
        totalRevisited: json["totalRevisited"],
        totalCancel: json["totalCancel"],
      );

  Map<String, dynamic> toJson() => {
        "totalDelivered": totalDelivered,
        "totalEarnings": totalEarnings,
        "totalRescheduled": totalRescheduled,
        "totalOnHold": totalOnHold,
        "totalRevisited": totalRevisited,
        "totalCancel": totalCancel,
      };
}
