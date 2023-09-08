// To parse this JSON data, do
//
//     final districtListModel = districtListModelFromJson(jsonString);

import 'dart:convert';

DistrictListModel districtListModelFromJson(String str) =>
    DistrictListModel.fromJson(json.decode(str));

String districtListModelToJson(DistrictListModel data) =>
    json.encode(data.toJson());

class DistrictListModel {
  final List<Datum>? data;
  final bool? success;
  final int? status;

  DistrictListModel({
    this.data,
    this.success,
    this.status,
  });

  factory DistrictListModel.fromJson(Map<String, dynamic> json) =>
      DistrictListModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "status": status,
      };
}

class Datum {
  final int? id;
  final String? name;
  final int? cityId;
  final int? status;

  Datum({
    this.id,
    this.name,
    this.cityId,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        cityId: json["city_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city_id": cityId,
        "status": status,
      };
}
