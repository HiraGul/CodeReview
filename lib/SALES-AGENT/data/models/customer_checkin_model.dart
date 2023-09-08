// To parse this JSON data, do
//
//     final customerCheckInModel = customerCheckInModelFromJson(jsonString);

import 'dart:convert';

CustomerCheckInModel customerCheckInModelFromJson(String str) =>
    CustomerCheckInModel.fromJson(json.decode(str));

String customerCheckInModelToJson(CustomerCheckInModel data) =>
    json.encode(data.toJson());

class CustomerCheckInModel {
  final List<Datum>? data;

  CustomerCheckInModel({
    this.data,
  });

  factory CustomerCheckInModel.fromJson(Map<String, dynamic> json) =>
      CustomerCheckInModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final int? id;
  final String? address;
  final String? shopName;
  final int? userId;
  final int? countryId;
  final int? cityId;
  final int? stateId;
  final String? locationLink;
  final dynamic latitude;
  final dynamic longitude;
  final String? countryName;
  final String? stateName;
  final String? cityName;
  final dynamic districtName;
  final User? user;

  Datum({
    this.id,
    this.address,
    this.shopName,
    this.userId,
    this.countryId,
    this.cityId,
    this.stateId,
    this.locationLink,
    this.latitude,
    this.longitude,
    this.countryName,
    this.stateName,
    this.cityName,
    this.districtName,
    this.user,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        address: json["address"],
        shopName: json["shop_name"],
        userId: json["user_id"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        stateId: json["state_id"],
        locationLink: json["location_link"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        countryName: json["country_name"],
        stateName: json["state_name"],
        cityName: json["city_name"],
        districtName: json["district_name"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "shop_name": shopName,
        "user_id": userId,
        "country_id": countryId,
        "city_id": cityId,
        "state_id": stateId,
        "location_link": locationLink,
        "latitude": latitude,
        "longitude": longitude,
        "country_name": countryName,
        "state_name": stateName,
        "city_name": cityName,
        "district_name": districtName,
        "user": user?.toJson(),
      };
}

class User {
  final String? name;
  final int? id;

  User({
    this.name,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
