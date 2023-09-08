import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom AppBar
Row buildAppBar(
    {required String title,
    required BuildContext context,
    required Function() onTap}) {
  return Row(
    children: [
      Expanded(
          child: InkWell(onTap: onTap, child: const Icon(Icons.arrow_back))),
      Expanded(
        flex: 5,
        child: Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 17.0.sp,
            color: const Color(0xFF222222),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const Spacer(
        flex: 3,
      )
    ],
  );
}
