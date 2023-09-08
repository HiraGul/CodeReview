import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

class CustomerShopWidget extends StatelessWidget {
  final String title;
  final String value;
  const CustomerShopWidget({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.sp,
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
                  fontSize: 14.0.sp,
                  color: const Color(0xFF707070),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: MySharedPrefs.getLocale()!
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: FittedBox(
                child: Text(
                  value,
                  style: GoogleFonts.openSans(
                    fontSize: 16.0.sp,
                    color: AppColors.blackColor,
                    height: 1.25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
