// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) => OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) => json.encode(data.toJson());

class OrderDetailModel {
    final String? message;
    final Orders? orders;

    OrderDetailModel({
        this.message,
        this.orders,
    });

    factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
        message: json["message"],
        orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "orders": orders?.toJson(),
    };
}

class Orders {
    final CustomerDetails? customerDetails;
    final List<Item>? items;
    final Summary? summary;
    final General? general;

    Orders({
        this.customerDetails,
        this.items,
        this.summary,
        this.general,
    });

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        customerDetails: json["customer_details"] == null ? null : CustomerDetails.fromJson(json["customer_details"]),
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        general: json["general"] == null ? null : General.fromJson(json["general"]),
    );

    Map<String, dynamic> toJson() => {
        "customer_details": customerDetails?.toJson(),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "summary": summary?.toJson(),
        "general": general?.toJson(),
    };
}

class CustomerDetails {
    final String? name;
    final String? idNumber;
    final String? shopName;
    final String? locationLink;
    final String? email;
    final String? address;
    final String? country;
    final String? state;
    final String? city;
    final dynamic postalCode;
    final dynamic phone;
    final String? shopType;
    final String? shopCategory;
    final String? districtName;

    CustomerDetails({
        this.name,
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
        this.districtName,
    });

    factory CustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
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

class General {
    final String? orderDate;
    final String? paymentStatus;
    final String? orderStatus;
    final String? paymentMethod;

    General({
        this.orderDate,
        this.paymentStatus,
        this.orderStatus,
        this.paymentMethod,
    });

    factory General.fromJson(Map<String, dynamic> json) => General(
        orderDate: json["orderDate"],
        paymentStatus: json["paymentStatus"],
        orderStatus: json["orderStatus"],
        paymentMethod: json["paymentMethod"],
    );

    Map<String, dynamic> toJson() => {
        "orderDate": orderDate,
        "paymentStatus": paymentStatus,
        "orderStatus": orderStatus,
        "paymentMethod": paymentMethod,
    };
}

class Item {
    final int? sNo;
    final String? name;
    final String? category;
    final String? brandName;
    final double? unitPrice;
    final int? quantity;
    final double? totalAmount;

    Item({
        this.sNo,
        this.name,
        this.category,
        this.brandName,
        this.unitPrice,
        this.quantity,
        this.totalAmount,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        sNo: json["s_no"],
        name: json["name"],
        category: json["category"],
        brandName: json["brandName"],
        unitPrice: json["unitPrice"]?.toDouble(),
        quantity: json["quantity"],
        totalAmount: json["totalAmount"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "s_no": sNo,
        "name": name,
        "category": category,
        "brandName": brandName,
        "unitPrice": unitPrice,
        "quantity": quantity,
        "totalAmount": totalAmount,
    };
}

class Summary {
    final int? totalItems;
    final int? totalQty;
    final double? totalAmount;

    Summary({
        this.totalItems,
        this.totalQty,
        this.totalAmount,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalItems: json["totalItems"],
        totalQty: json["totalQty"],
        totalAmount: json["totalAmount"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "totalQty": totalQty,
        "totalAmount": totalAmount,
    };
}
