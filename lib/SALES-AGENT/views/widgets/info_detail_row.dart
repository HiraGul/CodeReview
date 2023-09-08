import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_text.dart';

class InfoDetailRow extends StatelessWidget {
  const InfoDetailRow(
      {super.key,
      required this.tag,
      this.info,
      this.infoColor,
      this.tagColor,
      this.infoSize,
      this.tagSize,
      this.tagFlex,
      this.infoFlex});
  final String tag;
  final String? info;
  final Color? infoColor;
  final Color? tagColor;
  final double? infoSize;
  final double? tagSize;
  final int? tagFlex;
  final int? infoFlex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: tagFlex ?? 2,
          child: MyText(
            text: tag,
            size: tagSize ?? 13.sp,
            color: tagColor ?? forgetTextColor,
          ),
        ),
        // 22.pw,
        Expanded(
            flex: infoFlex ?? 4,
            child: MyText(
              text: info ?? '',
              size: infoSize ?? 14.sp,
              color: infoColor ?? Colors.black,
            ))
      ],
    );
  }
}
