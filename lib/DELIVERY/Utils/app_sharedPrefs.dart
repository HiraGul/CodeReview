import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/order_history_sharedprefs.dart';

import '../../SALES-AGENT/data/models/checkin_model.dart';
import '../../SALES-AGENT/data/models/customer_checkin_model.dart';
import 'strings.dart';

class MySharedPrefs {
  /// reference of Shared Preferences
  static SharedPreferences? preferences;

  /// init shared preference

  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  /// setter and getter of login

  static Future setIsLoggedIn({required bool isLoggedIn}) async =>
      await preferences!.setBool(Strings.isLoggedIn, isLoggedIn);

  static bool? getIsLoggedIn() => preferences!.getBool(Strings.isLoggedIn);

  /// setter and getter of locale

  static Future<bool> setLocale({required bool langLocale}) async =>
      await preferences!.setBool(Strings.language, langLocale);

  static bool? getLocale() => preferences!.getBool(Strings.language) ?? true;

  /// setter and getter of login user Data
  static Future<void> setUser(LoginModel loginModel) async {
    String data = loginModelToJson(loginModel);
    await preferences!.setString("user", data);
  }

  static LoginModel? getUser() {
    String data = preferences!.getString("user") ?? "";
    if (data.isNotEmpty) {
      return loginModelFromJson(data);
    } else {
      return null;
    }
  }

  /// setter and getter of checked in Data

  static Future<void> setCheckInData(CheckInModel model) async {
    String data = checkInModelToJson(model);
    await preferences!.setString('checkInData', data);
  }

  static CheckInModel? getCheckInData() {
    String data = preferences!.getString('checkInData') ?? "";

    if (data.isNotEmpty) {
      return checkInModelFromJson(data);
    }
    return null;
  }

  ///set and get customer data for check in and out
  static Future<void> setCustomerData(Datum customerData) async {
    var encode = customerData.toJson();
    String data = jsonEncode(encode);
    await preferences!.setString('customerData', data);
  }

  static Future<Datum?> getCustomerData() async {
    String data = preferences!.getString('customerData') ?? "";
    if (data.isNotEmpty) {
      var decode = await jsonDecode(data);
      return Datum.fromJson(decode);
    }
    return null;
  }

  ///set userType
  static Future<void> setUserType(String userType) async {
    await preferences!.setString('userType', userType);
  }

  static String? getUserType() {
    String data = preferences!.getString('userType') ?? "";
    if (data.isNotEmpty) {
      return data;
    }
    return null;
  }

  /// setter and getter of order Details
  static Future<void> setOrderData(
      OrderHistoryModelSharedPrefs orderHistoryModelSharedPrefs) async {
    var encode = orderHistoryModelSharedPrefs.toJson();
    String data = jsonEncode(encode);
    await preferences!.setString('orderHistory', data);
  }

  static OrderHistoryModelSharedPrefs? getOrderData() {
    String data = preferences!.getString('orderHistory') ?? "";
    if (data.isNotEmpty) {
      var decode = jsonDecode(data);
      print("Decoded Data $decode");
      return OrderHistoryModelSharedPrefs.fromJson(decode);
    }
    return null;
  }

  /// clear shared preference
  static Future clearSharedPreferences() async => preferences!.clear();
}
