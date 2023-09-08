import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

class IconsWidget extends StatelessWidget {
  final IconData iconData;
  const IconsWidget({required this.iconData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.sp),
      width: 28.0.sp,
      height: 22.84.sp,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F8),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFF2F3F8),
        ),
      ),
      child: Center(
          child: Icon(
        iconData,
        color: AppColors.bolGreyColor,
        size: 20.sp,
      )),
    );
  }
}
