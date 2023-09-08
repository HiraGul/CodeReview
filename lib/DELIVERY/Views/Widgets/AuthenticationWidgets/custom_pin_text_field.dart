import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

class CustomPinTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomPinTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44.sp),
      child: PinCodeTextField(
        controller: controller,
          textStyle: const TextStyle(color: Colors.black),
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            selectedColor: AppColors.greenColor,
            inactiveColor: AppColors.greyColor,
            activeColor: AppColors.greenColor,
          ),
          appContext: context,
          length: 6,
          onChanged: (value) {}),
    );
  }
}
