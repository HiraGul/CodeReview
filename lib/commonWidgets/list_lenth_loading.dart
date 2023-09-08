import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

listLoadingIndicator({required Color color}) {
  return LoadingAnimationWidget.prograssiveDots(
    color: color,
    size: 40.sp,
  );
}
