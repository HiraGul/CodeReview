// To parse this JSON data, do
//
//     final payLoadModel = payLoadModelFromJson(jsonString);

import 'dart:convert';

PayLoadModel payLoadModelFromJson(String str) =>
    PayLoadModel.fromJson(json.decode(str));

String payLoadModelToJson(PayLoadModel data) => json.encode(data.toJson());

class PayLoadModel {
  final String route;
  final String itemTypeId;
  final String itemType;
  final String clickAction;

  PayLoadModel({
    required this.route,
    required this.itemTypeId,
    required this.clickAction,
    required this.itemType,
  });

  factory PayLoadModel.fromJson(Map<String, dynamic> json) => PayLoadModel(
        route: json["route"],
        itemTypeId: json[" item_type_id"],
        itemType: json[" item_type"],
        clickAction: json[" click_action"],
      );

  Map<String, dynamic> toJson() => {
        " route": route,
        " item_type_id": itemTypeId,
        " item_type": itemType,
        " click_action": clickAction,
      };
}
