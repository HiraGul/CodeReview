import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'my_text.dart';

class ExpandRowWidget extends StatelessWidget {
  const ExpandRowWidget(
      {super.key,
      required this.item1,
      required this.item2,
      required this.item1Color,
      required this.item2Color,
      this.item1Weight,
      this.item2Weight,
      this.item2Size});

  final String item1;
  final String item2;
  final Color item1Color;
  final Color item2Color;
  final FontWeight? item1Weight;
  final FontWeight? item2Weight;
  final double? item2Size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MyText(
            text: item1,
            size: 13.sp,
            color: item1Color,
            weight: item1Weight,
          ),
        ),
        Expanded(
            child: MyText(
          textAlign: TextAlign.end,
          text: item2,
          size: item2Size ?? 13.sp,
          color: item2Color,
          weight: item2Weight,
        ))
      ],
    );
  }
}
