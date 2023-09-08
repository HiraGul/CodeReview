import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

class DeliveryStatusCard extends StatelessWidget {
  final String title;
  final String leadingIcon;
  final String value;
  const DeliveryStatusCard({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 382.0.sp,
      height: 112.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0.r),
        color: Colors.white,
        border: Border.all(width: 1.0, color: AppColors.kDisableButtonColor),
      ),
      child: Row(
        children: <Widget>[
          const Spacer(
            flex: 2,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                leadingIcon,
                width: 43.2.sp,
                height: 48.0.sp,
              ),
            ),
          ),
          SizedBox(
            width: 25.sp,
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  child: Align(
                    alignment: MySharedPrefs.getLocale()!
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      title,
                      style: GoogleFonts.openSans(
                        fontSize: 20.0.sp,
                        color: AppColors.deliveredTitleColor,
                        fontWeight: FontWeight.w600,
                        height: 0.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: MySharedPrefs.getLocale()!
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      value,
                      style: GoogleFonts.openSans(
                        fontSize: 32.0.sp,
                        color: title == 'Delivered'
                            ? AppColors.greenColor
                            : AppColors.orangeColor,
                        fontWeight: FontWeight.w700,
                        height: 1.13,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
