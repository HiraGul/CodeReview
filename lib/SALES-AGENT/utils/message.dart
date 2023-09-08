import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_text.dart';

showMessage(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: loginBtnColor,
      content: MyText(
        text: message,
        size: 16.sp,
        color: Colors.white,
        weight: FontWeight.w400,
      )));
}
