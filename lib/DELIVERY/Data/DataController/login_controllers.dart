import 'package:flutter/material.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/logout_model.dart';

class AuthControllers {
  static final TextEditingController phoneNumberController =
      TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  static String? userType;

  static LoginModel? loginModelController;

  static LogoutModel logoutModelController =
      LogoutModel(result: false, message: '');
}
