// To parse this JSON data, do
//
//     final assignedOrderModel = assignedOrderModelFromJson(jsonString);

import 'dart:convert';

AssignedOrderModel assignedOrderModelFromJson(String str) =>
    AssignedOrderModel.fromJson(json.decode(str));

String assignedOrderModelToJson(AssignedOrderModel data) =>
    json.encode(data.toJson());

class AssignedOrderModel {
  List<Datum> data;

  AssignedOrderModel({
    required this.data,
  });

  factory AssignedOrderModel.fromJson(Map<String, dynamic> json) =>
      AssignedOrderModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String orderCode;
  String total;
  String orderDate;
  String customerName;
  Address address;
  String paymentStatus;
  String deliveryStatus;
  String? deliveryBoyOrderStatus;
  int? deliveryBoyPriority;

  Datum({
    required this.id,
    required this.orderCode,
    required this.total,
    required this.orderDate,
    required this.customerName,
    required this.address,
    required this.paymentStatus,
    required this.deliveryStatus,
    required this.deliveryBoyOrderStatus,
    this.deliveryBoyPriority,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        orderCode: json["order_code"],
        total: json["total"],
        orderDate: json["order_date"],
        customerName: json["customer_name"] ?? '        ',
        address: Address.fromJson(json["address"]),
        paymentStatus: json["payment_status"],
        deliveryStatus: json["delivery_status"],
        deliveryBoyOrderStatus: json["delivery_boy_order_status"],
        deliveryBoyPriority: json["delivery_boy_priority" ?? 0],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_code": orderCode,
        "total": total,
        "order_date": orderDate,
        "customer_name": customerName,
        "address": address.toJson(),
        "payment_status": paymentStatus,
        "delivery_status": deliveryStatus,
        "delivery_boy_order_status": deliveryBoyOrderStatus,
        "delivery_boy_priority": deliveryBoyPriority,
      };
}

class Address {
  String name;
  String? idNumber;
  String? shopName;
  String? locationLink;
  String? email;
  dynamic address;
  String? country;
  String? state;
  String? city;
  dynamic postalCode;
  dynamic phone;
  String? shopType;
  String? shopCategory;
  String? districtName;
  String? latLang;

  Address(
      {required this.name,
      required this.idNumber,
      required this.shopName,
      required this.locationLink,
      required this.email,
      required this.address,
      required this.country,
      required this.state,
      required this.city,
      required this.postalCode,
      required this.phone,
      required this.shopType,
      required this.shopCategory,
      required this.districtName,
      required this.latLang});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"],
        idNumber: json["id_number"],
        shopName: json["shop_name"],
        locationLink: json["location_link"],
        email: json["email"],
        address: json["address"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postalCode: json["postal_code"],
        phone: json["phone"],
        shopType: json["shop_type"],
        shopCategory: json["shop_category"],
        districtName: json["district_name"],
        latLang: json["lat_lang"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id_number": idNumber,
        "shop_name": shopName,
        "location_link": locationLink,
        "email": email,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "postal_code": postalCode,
        "phone": phone,
        "shop_type": shopType,
        "shop_category": shopCategory,
        "district_name": districtName,
      };
}
