import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

flutterSnackBar(
  BuildContext context,
  String message,
) async {
  return await Flushbar(
    backgroundColor: AppColors.primaryColor,
    title: '',
    message: message.tr(),
    messageSize: 16.sp,
    titleSize: 22.sp,
    duration: const Duration(seconds: 2),
  ).show(context);
}
