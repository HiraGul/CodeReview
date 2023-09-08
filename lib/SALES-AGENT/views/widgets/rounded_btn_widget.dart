import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedBtnWidget extends StatelessWidget {
  const RoundedBtnWidget(
      {super.key,
      required this.widget,
      required this.color,
      required this.onPressed,
      this.textSize,
      this.textWeight});

  final Widget widget;
  final Color color;
  final VoidCallback onPressed;
  final double? textSize;
  final FontWeight? textWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48.sp,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: color,
                shape: const StadiumBorder()),
            onPressed: onPressed,
            child: widget));
  }
}
