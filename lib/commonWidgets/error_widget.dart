import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomErrorStateIndicator extends StatefulWidget {
  final void Function() onTap;

  const CustomErrorStateIndicator({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomErrorStateIndicator> createState() =>
      _CustomErrorStateIndicatorState();
}

class _CustomErrorStateIndicatorState extends State<CustomErrorStateIndicator> {
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
              const Icon(
                Icons.error,
                color: Colors.red,
              ),
              SizedBox(
                width: 10.sp,
              ),
              Text(
                'SORRY'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
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
            'Something went wrong'.tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
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
            onTap: widget.onTap,
            child: Text(
              'Please Try again'.tr(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.red,
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
