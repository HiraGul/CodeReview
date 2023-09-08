import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

TextEditingController partialPayController = TextEditingController();

class ColumnWidget extends StatelessWidget {
  final String title;
  final String value;
  const ColumnWidget({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.sp,
      margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: MySharedPrefs.getLocale()!
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(
                title,
                style: GoogleFonts.openSans(
                  fontSize: 16.0.sp,
                  color: const Color(0xFF1C1C1C),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          value != 'textField'
              ? Expanded(
                  child: Align(
                    alignment: MySharedPrefs.getLocale()!
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: FittedBox(
                      child: Text(
                        value,
                        style: GoogleFonts.openSans(
                          fontSize: 16.0.sp,
                          color: const Color(0xFF707171),
                        ),
                      ),
                    ),
                  ),
                )
              : Expanded(
                  flex: 2,
                  child: TextField(
                    style: GoogleFonts.openSans(
                      fontSize: 16.0.sp,
                      color: const Color(0xFF707171),
                    ),
                    keyboardType: TextInputType.number,
                    controller: partialPayController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 22.sp,
                            top: 10.sp,
                            bottom: 10.sp,
                            right: 30.sp),
                        hintText: 'Amount'.tr(),
                        hintStyle: GoogleFonts.openSans(
                            color: AppColors.themeGray, fontSize: 16.sp),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.r),
                            borderSide: BorderSide(
                                color: AppColors.themeLightGray, width: 1.sp)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.r),
                            borderSide: BorderSide(
                                color: AppColors.themeLightGray, width: 1.sp)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.r),
                            borderSide: BorderSide(
                                color: AppColors.themeLightGray, width: 1.sp)),
                        filled: true,
                        fillColor: AppColors.whiteColor),
                  ),
                ),
        ],
      ),
    );
  }
}
