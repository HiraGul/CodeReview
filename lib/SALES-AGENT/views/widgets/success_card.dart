import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';

import '../../utils/app_colors.dart';
import '../../utils/images_url.dart';
import 'my_text.dart';

class SuccessCard extends StatelessWidget {
  const SuccessCard(
      {super.key, required this.title, required this.description});

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 195.sp,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(checkCircleSvg),
          SvgPicture.asset(checkCircleSvg),
          13.ph,
          MyText(
            text: title,
            size: 18.sp,
            weight: FontWeight.w400,
            color: greenColor,
          ),
          5.ph,
          MyText(
            textAlign: TextAlign.center,
            text: description,
            size: 14.sp,
          )
        ],
      ),
    );
  }
}
