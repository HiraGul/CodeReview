// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final bool? result;
  final String? message;
  final String? accessToken;
  final String? tokenType;
  final dynamic expiresAt;
  final User? user;

  LoginModel({
    this.result,
    this.message,
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        result: json["result"],
        message: json["message"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresAt: json["expires_at"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt,
        "user": user?.toJson(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final dynamic avatar;
  final String? avatarOriginal;
  final String? phone;
  final String? userType;
  final dynamic verified;

  User({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.avatarOriginal,
    this.phone,
    this.userType,
    this.verified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        avatarOriginal: json["avatar_original"],
        phone: json["phone"],
        userType: json["user_type"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
        "avatar_original": avatarOriginal,
        "phone": phone,
        "user_type": userType,
        "verified": verified,
      };
}
