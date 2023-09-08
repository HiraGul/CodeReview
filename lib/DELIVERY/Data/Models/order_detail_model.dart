import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  Data data;
  bool? success;
  String? message;

  OrderDetailModel({required this.data, this.success, this.message});

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      data: Data.fromJson(json['data'] ?? {}),
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  ShippingAddress? shippingAddress;
  String? deliveryStatus;
  double? grandTotal;
  String? tax;
  String? code;
  String? subTotal;
  String? date;
  List<OrderDetails>? orderDetails;

  Data(
      {this.id,
      required this.tax,
      this.shippingAddress,
      this.deliveryStatus,
      this.grandTotal,
      this.subTotal,
      this.code,
      this.date,
      this.orderDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tax = json['tax'] ?? '0';

    subTotal = json['subtotal'] ?? '0';
    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
    deliveryStatus = json['delivery_status'];
    grandTotal = json['grand_total'].toDouble() ?? 0.0;
    code = json['code'];
    date = json['date'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress!.toJson();
    }
    data['delivery_status'] = deliveryStatus;
    data['grand_total'] = grandTotal;
    data['code'] = code;
    data['date'] = date;
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingAddress {
  String? name;
  String? idNumber;
  String? shopName;
  String? locationLink;
  String? email;
  String? address;
  String? country;
  String? state;
  String? city;
  String? postalCode;
  String? phone;
  String? shopType;
  String? shopCategory;
  String? districtName;

  ShippingAddress(
      {this.name,
      this.idNumber,
      this.shopName,
      this.locationLink,
      this.email,
      this.address,
      this.country,
      this.state,
      this.city,
      this.postalCode,
      this.phone,
      this.shopType,
      this.shopCategory,
      this.districtName});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    idNumber = json['id_number'];
    shopName = json['shop_name'];
    locationLink = json['location_link'];
    email = json['email'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    shopType = json['shop_type'];
    shopCategory = json['shop_category'];
    districtName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id_number'] = idNumber;
    data['shop_name'] = shopName;
    data['location_link'] = locationLink;
    data['email'] = email;
    data['address'] = address;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['postal_code'] = postalCode;
    data['phone'] = phone;
    data['shop_type'] = shopType;
    data['shop_category'] = shopCategory;
    data['district_name'] = districtName;
    return data;
  }
}

class OrderDetails {
  int? productId;
  dynamic price;
  int? quantity;
  dynamic tax;
  int? orderId;
  Product? product;
  double? perQuantityTax;
  double? perQuantityPrice;
  int? maxQuantity;

  OrderDetails({
    this.productId,
    this.price,
    this.quantity,
    this.perQuantityPrice,
    this.orderId,
    this.product,
    this.tax,
    this.perQuantityTax,
    this.maxQuantity,
  });

  OrderDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    maxQuantity = json['quantity'] ?? 0;
    perQuantityTax = json['tax'] / json['quantity'];
    perQuantityPrice = json['price'] / json['quantity'];
    price = json['price'].toDouble() ?? 0.0;
    tax = json['tax'] ?? 0;
    quantity = json['quantity'] ?? 0;
    orderId = json['order_id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['price'] = price;
    data['quantity'] = quantity;
    data['order_id'] = orderId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  String? name;
  int? id;

  Product({this.name, this.id});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
