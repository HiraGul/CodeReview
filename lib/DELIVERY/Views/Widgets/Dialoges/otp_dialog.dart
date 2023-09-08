import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final String icon;
  final String title;
  final Color iconColor;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final String description;
  final VoidCallback? confirmButton;

  const CustomDialog(
      {Key? key,
      this.confirmButton,
      required this.title,
      required this.icon,
      required this.iconColor,
      required this.titleStyle,
      required this.descriptionStyle,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: confirmButton != null ? 240.sp : 195.sp,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: SvgPicture.asset(
                  icon,
                  color: iconColor,
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(title, style: titleStyle),
            )),
            Expanded(
                child: FittedBox(
              child: Text(
                description,
                style: descriptionStyle,
              ),
            )),
            confirmButton == null
                ? const SizedBox()
                : Expanded(
                    child: CustomButton(
                      onTap: confirmButton ?? () {},
                      iconCheck: 0,
                      title: 'Continue',
                      buttonColor: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
