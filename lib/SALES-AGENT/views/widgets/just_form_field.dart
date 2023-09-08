import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../../utils/email_formate.dart';

class JustFormField extends StatefulWidget {
  const JustFormField({
    super.key,
    this.enabled = true,
    this.isRequired = true,
    this.suffixIcon,
    this.isPasswordField = false,
    required this.controller,
    required this.label,
    this.hintText,
    this.fieldHeight,
  });

  final bool? enabled;
  final bool? isPasswordField;
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final bool? isRequired;
  final Widget? suffixIcon;
  final double? fieldHeight;

  @override
  State<JustFormField> createState() => _JustFormFieldState();
}

class _JustFormFieldState extends State<JustFormField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        child: TextFormField(
          enabled: widget.enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: widget.isPasswordField! ? showPassword : false,
          controller: widget.controller,
          validator: !widget.isRequired!
              ? (value) {
                  return null;
                }
              : (value) {
                  if (value == null || value.isEmpty) {
                    return '"${widget.label}" ${"is required".tr()}';
                  }
                  if ((widget.label?.toLowerCase() ?? "").contains("email")) {
                    if (!emailRegex.hasMatch(value)) {
                      return "email is badly formatted".tr();
                    }
                  } else {
                    return null;
                  }
                  return null;
                },
          style: TextStyle(fontSize: 16.sp, height: widget.fieldHeight),
          decoration: InputDecoration(
            filled: true,
            errorMaxLines: 1,
            fillColor: widget.enabled! ? Colors.white : const Color(0xffF5F5F5),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.sp, vertical: 0.sp),
            // constraints: BoxConstraints(
            //   maxHeight: 36.h,
            // ),
            errorStyle: TextStyle(fontSize: 8.sp, height: 0.2.sp),
            hintStyle:
                GoogleFonts.openSans(fontSize: 16.sp, color: forgetTextColor),
            hintText: widget.hintText,
            suffixIcon: widget.isPasswordField!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Image.asset(
                      'assets/images/View Password Button.png',
                      height: 10.sp,
                    ),
                  )
                : widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: const BorderSide(
                color: fieldBorderColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.sp),
              borderSide: const BorderSide(
                color: fieldBorderColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.sp),
              borderSide: const BorderSide(
                color: Colors.redAccent,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.sp),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.sp),
              borderSide: const BorderSide(
                color: fieldBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.sp),
              borderSide: const BorderSide(
                color: fieldBorderColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
