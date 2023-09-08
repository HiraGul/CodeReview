import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//extension for width and height spacing
extension padding on num {
  SizedBox get ph => SizedBox(
        height: toDouble().sp,
      );
  SizedBox get pw => SizedBox(
        width: toDouble().sp,
      );
}

//for widget to apply some padding
extension WidgetPadding on Widget {
  Widget widgetPadding() {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: this,
    );
  }
}
