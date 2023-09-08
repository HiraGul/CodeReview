// To parse this JSON data, do
//
//     final customerDetailModel = customerDetailModelFromJson(jsonString);

import 'dart:convert';

CustomerDetailModel customerDetailModelFromJson(String str) =>
    CustomerDetailModel.fromJson(json.decode(str));

String customerDetailModelToJson(CustomerDetailModel data) =>
    json.encode(data.toJson());

class CustomerDetailModel {
  final String? message;
  final Customer? customer;

  CustomerDetailModel({
    this.message,
    this.customer,
  });

  factory CustomerDetailModel.fromJson(Map<String, dynamic> json) =>
      CustomerDetailModel(
        message: json["message"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "customer": customer?.toJson(),
      };
}

class Customer {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? secondaryPhone;
  final String? idNumber;
  final String? vatNumber;
  final String? licenseNumber;
  final String? shopName;
  final String? locationLink;
  final dynamic longitude;
  final dynamic latitude;
  final String? district;
  final String? country;
  final String? city;
  final String? state;
  final dynamic postalCode;
  final String? shopType;
  final String? shopAddress;
  final String? crImage;
  final String? vatImage;
  final String? shopImage;

  Customer({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.secondaryPhone,
    this.idNumber,
    this.vatNumber,
    this.licenseNumber,
    this.shopName,
    this.locationLink,
    this.longitude,
    this.latitude,
    this.district,
    this.country,
    this.city,
    this.state,
    this.postalCode,
    this.shopType,
    this.shopAddress,
    this.crImage,
    this.vatImage,
    this.shopImage,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        secondaryPhone: json["secondary_phone"],
        idNumber: json["id_number"],
        vatNumber: json["vat_number"],
        licenseNumber: json["license_number"],
        shopName: json["shop_name"],
        locationLink: json["location_link"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        district: json["district"],
        country: json["country"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        shopType: json["shop_type"],
        shopAddress: json["shop_address"],
        crImage: json["cr_image"],
        vatImage: json["vat_image"],
        shopImage: json["shop_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "secondary_phone": secondaryPhone,
        "id_number": idNumber,
        "vat_number": vatNumber,
        "license_number": licenseNumber,
        "shop_name": shopName,
        "location_link": locationLink,
        "longitude": longitude,
        "latitude": latitude,
        "district": district,
        "country": country,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "shop_type": shopType,
        "shop_address": shopAddress,
        "cr_image": crImage,
        "vat_image": vatImage,
        "shop_image": shopImage,
      };
}
