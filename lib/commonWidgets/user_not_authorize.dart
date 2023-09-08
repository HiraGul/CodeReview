import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';

import '../DELIVERY/Utils/colors.dart';

class UserNotAuthorized extends StatelessWidget {
  const UserNotAuthorized({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.sp),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SORRY'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            'User Not Authorized'.tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 25.sp,
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(context, Strings.splashScreen);
            },
            child: Text(
              'Back To Login'.tr(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: AppColors.orangeColor,
                decoration: TextDecoration.underline,
                fontSize: 15.sp,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
