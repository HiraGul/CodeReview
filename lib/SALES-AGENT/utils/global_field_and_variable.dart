import 'package:flutter/material.dart';

TextEditingController checkoutReason = TextEditingController();
var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();
var secondPhoneController = TextEditingController();
var idController = TextEditingController();
var passwordController = TextEditingController();
var shopNameController = TextEditingController();
var shopAddressController = TextEditingController();
var postalCodeController = TextEditingController();
var vatController = TextEditingController();
var licenseController = TextEditingController();
String? shopType, crImage, certificateImage, shopImage, locationLink;
List<String> shopCategory = [];
int? countryId, cityId, stateId, districtId;
double? myLatitude, myLongitude;

//login Controller
var loginPhoneController = TextEditingController();
var loginPassController = TextEditingController();
