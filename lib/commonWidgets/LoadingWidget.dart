import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

loadingIndicator({Color? dotColor}) {
  return LoadingAnimationWidget.flickr(
    leftDotColor: dotColor ?? AppColors.primaryColor,
    rightDotColor: AppColors.orangeColor,
    size: 60.sp,
  );
}
