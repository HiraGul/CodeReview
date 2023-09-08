import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';

class RowWidget extends StatelessWidget {
  final String title;
  final Widget widget2;
  const RowWidget({required this.title, required this.widget2, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.sp),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: MySharedPrefs.getLocale()!
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(
                title,
                style: GoogleFonts.openSans(
                  fontSize: 13.0.sp,
                  color: const Color(0xFF111111),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
                alignment: MySharedPrefs.getLocale()!
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: widget2),
          ),
        ],
      ),
    );
  }
}
