import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_text.dart';

class PayRequestComponent extends StatelessWidget {
  const PayRequestComponent(
      {super.key,
      required this.routeString,
      required this.buttonText,
      required this.color,
      required this.requests});

  final String routeString;
  final String buttonText;
  final Color color;
  final String requests;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeString);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 55.sp),
        height: 48.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.sp),
            shape: BoxShape.rectangle,
            border: Border.all(color: color)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: MyText(
                textAlign: TextAlign.center,
                text: buttonText.tr(),
                size: 20.sp,
                weight: FontWeight.w500,
                color: color,
              ),
            ),
            Expanded(
              child: Container(
                height: 30.sp,
                width: 30.sp,
                // margin: EdgeInsets.only(right: 12.sp, left: 60.sp),
                alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                child: MyText(
                  text: requests,
                  size: 14.sp,
                  weight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
