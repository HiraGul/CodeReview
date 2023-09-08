import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.parentContext,
    required this.leadingSize,
    required this.title,
    this.action,
    required this.titleColor,
    this.appBarColor,
    this.titleSize,
    this.titleWeight,
    required this.onPressed,
  });

  final BuildContext parentContext;
  final double leadingSize;
  final Widget title;
  final List<Widget>? action;
  final Color titleColor;
  final Color? appBarColor;
  final double? titleSize;
  final FontWeight? titleWeight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 25.sp,
      leading: Padding(
        padding: EdgeInsets.only(top: 10.sp),
        child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_back,
              size: leadingSize,
            )),
      ),
      backgroundColor: appBarColor ?? scaffoldColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Padding(
        padding: EdgeInsets.only(top: 10.sp),
        child: title,
      ),
      actions: action,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, kToolbarHeight.sp);
}
