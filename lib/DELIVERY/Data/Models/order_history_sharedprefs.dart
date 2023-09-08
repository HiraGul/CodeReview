import 'dart:convert';

import 'package:tojjar_delivery_app/DELIVERY/Data/Models/order_detail_model.dart';

OrderHistoryModelSharedPrefs orderDetailModelFromJson(String str) =>
    OrderHistoryModelSharedPrefs.fromJson(json.decode(str));

String orderDetailModelToJson(OrderHistoryModelSharedPrefs data) =>
    json.encode(data.toJson());

class OrderHistoryModelSharedPrefs {
  int? id;
  double? grandTotal;
  List<Product>? products;

  OrderHistoryModelSharedPrefs({this.id, this.grandTotal, this.products});

  OrderHistoryModelSharedPrefs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grandTotal = json['grand_total'].toDouble() ?? 0.0;
    if (json['order_details'] != null) {
      products = <Product>[];
      json['order_details'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['grand_total'] = grandTotal;
    if (products != null) {
      data['order_details'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
