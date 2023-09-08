import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

class PrintWidget extends StatelessWidget {
  const PrintWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.0.sp,
      height: 30.0.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: const Color(0xFF4F7491),
        border: Border.all(
          width: 2.0.sp,
          color: const Color(0xFF4F7491),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.print,
            color: AppColors.whiteColor,
            size: 20.sp,
          ),
          SizedBox(
            width: 10.sp,
          ),
          Text(
            'Print'.tr(),
            style: GoogleFonts.openSans(
              fontSize: 14.0.sp,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
