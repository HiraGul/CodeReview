import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';

/// Summary Widget of the Summary Screen to show the driver the daily summary
/// of deliver and not deliver orders
buildSummaryColumn({required int count, required String text}) {
  return SizedBox(
    height: 40.sp,
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Align(
            alignment: MySharedPrefs.getLocale()!
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Text(
              text,
              style: GoogleFonts.openSans(
                fontSize: 16.0.sp,
                color: const Color(0xFF2E2E2E),
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
            child: Text(
              "$count",
              style: GoogleFonts.cairo(
                fontSize: 16.0.sp,
                color: const Color(0xFF2E2E2E),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
