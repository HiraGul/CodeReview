import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';

import '../../../widgets/my_text.dart';

class RowCellComponent extends StatelessWidget {
  const RowCellComponent({super.key, required this.text, this.tag});

  final String? text;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15.sp, top: 15.sp, bottom: 5.sp),
      // height: 60.sp,
      child: tag == "customer"
          ? MyText(
              text: text ?? '',
              size: 13.sp,
              color: textDarkColor,
              weight: FontWeight.w400,
            )
          : MyText(
              text: text ?? '',
              size: 13.sp,
              color: textDarkColor,
              weight: FontWeight.w400,
            ),
    );
  }
}
