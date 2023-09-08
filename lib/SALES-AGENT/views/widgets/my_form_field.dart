import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/required_field_label.dart';

import '../../utils/app_colors.dart';
import '../../utils/email_formate.dart';

class MyFormField extends StatefulWidget {
  final bool? enabled;
  final bool? isPasswordField;
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final bool? isRequired;
  final Widget? suffixIcon;
  final int? maxLine;
  final TextInputType keyboardType;

  const MyFormField({
    Key? key,
    this.enabled = true,
    this.isRequired = true,
    this.suffixIcon,
    this.isPasswordField = false,
    required this.controller,
    required this.label,
    this.hintText,
    this.maxLine,
    required this.keyboardType,
  }) : super(key: key);

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.label == null
            ? const SizedBox()
            : RequiredFieldLabel(
                isRequired: widget.isRequired!,
                title: widget.label!,
              ),
        6.ph,
        Align(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            keyboardType: widget.keyboardType,
            cursorColor: loginBtnColor,
            cursorHeight: 20.sp,
            enabled: widget.enabled,
            // autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            obscureText: widget.isPasswordField! ? showPassword : false,
            controller: widget.controller,
            maxLines: widget.maxLine ?? 1,
            validator: !widget.isRequired!
                ? (value) {
                    return null;
                  }
                : (value) {
                    if (value == null || value.isEmpty) {
                      return ' ${widget.label} ${"is required".tr()}';
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
            style: TextStyle(
              fontSize: 16.sp,
              // height: widget.fieldHeight
            ),
            decoration: InputDecoration(
              filled: true,
              errorMaxLines: 1,
              fillColor: whiteColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 15.sp,
                  vertical: widget.maxLine != null ? 10.sp : 0),
              // constraints: BoxConstraints(
              //   maxHeight: 36.h,
              // ),
              errorStyle: TextStyle(
                fontSize: 12.sp,
                height: 0.2.sp,
              ),

              hintStyle:
                  GoogleFonts.openSans(fontSize: 16.sp, color: fieldHintColor),
              hintText: widget.hintText,
              // suffixIcon: widget.isPasswordField!
              //     ? IconButton(
              //         onPressed: () {
              //           setState(() {
              //             showPassword = !showPassword;
              //           });
              //         },
              //         icon: Image.asset(
              //           'assets/images/View Password Button.png',
              //           height: 10.sp,
              //         ),
              //       )
              //     : widget.suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.sp),
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
      ],
    );
  }
}
