import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final bool? obSecure;
  final double? borderRadius;
  final IconButton? suffixIcon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final int? minLines;
  final int? maxLines;
  const CustomTextField(
      {Key? key,
      this.obSecure = false,
      required this.hintText,
      required this.controller,
      this.textInputType,
      this.maxLines,
      this.minLines,
      this.borderRadius,
      this.suffixIcon})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 44.sp,
      child: TextField(
        keyboardType: widget.textInputType,
        minLines: widget.minLines,
        controller: widget.controller,
        obscureText: widget.obSecure!,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                left: 22.sp, top: 10.sp, bottom: 10.sp, right: 10.sp),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.openSans(
                color: AppColors.themeGray, fontSize: 16.sp),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.r),
                borderSide:
                    BorderSide(color: AppColors.themeLightGray, width: 1.sp)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.r),
                borderSide:
                    BorderSide(color: AppColors.themeLightGray, width: 1.sp)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.r),
                borderSide:
                    BorderSide(color: AppColors.themeLightGray, width: 1.sp)),
            suffixIcon: widget.suffixIcon ?? const SizedBox(),
            filled: true,
            fillColor: AppColors.whiteColor),
      ),
    );
  }
}
