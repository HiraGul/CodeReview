import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0.r),
          color: Colors.white,
          border: Border.all(width: 1.0, color: Colors.white),
        ),
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.only(bottom: 40.sp),
          shrinkWrap: true,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(Images.emptyCard)),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'SORRY'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: AppColors.primaryColor,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'No data is Available to show'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
