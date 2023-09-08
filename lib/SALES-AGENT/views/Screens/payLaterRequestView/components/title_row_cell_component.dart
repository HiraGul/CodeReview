import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../widgets/my_text.dart';

class TitleRowCellComponent extends StatelessWidget {
  const TitleRowCellComponent(
      {super.key, required this.text, required this.height});

  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Align(
        alignment: Alignment.center,
        child: MyText(
          textAlign: TextAlign.center,
          text: text,
          size: 13.5.sp,
          weight: FontWeight.w600,
          color: loginBtnColor,
        ),
      ),
    );
  }
}
