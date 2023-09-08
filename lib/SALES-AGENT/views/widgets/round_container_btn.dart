import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'my_text.dart';

class RoundContainerBtn extends StatelessWidget {
  const RoundContainerBtn(
      {super.key,
      required this.textColor,
      required this.borderColor,
      required this.text,
      required this.onTap,
      this.textSize,
      this.textWeight});

  final Color textColor;
  final Color borderColor;
  final String text;
  final VoidCallback onTap;
  final double? textSize;
  final FontWeight? textWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 48.sp,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(30.sp)),
        child: MyText(
          text: text,
          size: textSize ?? 16.sp,
          weight: textWeight,
          color: textColor,
        ),
      ),
    );
  }
}
