import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

import '../AuthenticationWidgets/custom_button.dart';

class ReachedButtonWidget extends StatelessWidget {
  final bool? isDisabled;
  final String title;
  final VoidCallback onTap;
  final Color buttonColor;
  const ReachedButtonWidget({
    required this.title,
    required this.onTap,
    this.isDisabled,
    required this.buttonColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 150.sp,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: AppColors.kDisableButtonColor,
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
        ],
        borderRadius: BorderRadius.circular(4.0.r),
        color: Colors.white,
        border: Border.all(width: 1.0, color: AppColors.kDisableButtonColor),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 40.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.sp),
            child: CustomButton(
              iconCheck: 3,
              height: 52.sp,
              onTap: onTap,
              isDisabled: isDisabled,
              title: title,
              buttonColor: buttonColor,
              textColor: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
