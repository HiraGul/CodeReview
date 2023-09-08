// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  final String? message;
  final Data? data;

  DashboardModel({
    this.message,
    this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? customers;
  final int? orders;
  final int? totalPendingRequests;
  final int? totalPartialPaymentPendingRequests;

  Data(
      {this.customers,
      this.orders,
      this.totalPendingRequests,
      this.totalPartialPaymentPendingRequests});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      customers: json["customers"],
      orders: json["orders"],
      totalPendingRequests: json["totalPendingRequests"],
      totalPartialPaymentPendingRequests:
          json['totalPartialPaymentPendingRequests']);

  Map<String, dynamic> toJson() => {
        "customers": customers,
        "orders": orders,
        "totalPendingRequests": totalPendingRequests,
        "totalPartialPaymentPendingRequests": totalPartialPaymentPendingRequests
      };
}
