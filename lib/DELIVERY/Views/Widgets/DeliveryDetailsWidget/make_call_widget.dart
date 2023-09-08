import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/dialpad.dart';

/// call widget
class MakeCallWidget extends StatelessWidget {
  String phoneNumber;
  MakeCallWidget({
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (phoneNumber == 'null' || phoneNumber == '')
        ? const SizedBox()
        : InkWell(
            onTap: () {
              DialPadLauncher.launch(phoneNumber, context);
            },
            child: Container(
              padding: EdgeInsets.only(right: 10.sp, left: 10.sp),
              alignment: Alignment.center,
              height: 30.0.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white,
                border: Border.all(width: 2.0, color: AppColors.primaryColor),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.call,
                      color: AppColors.primaryColor,
                      size: 22.sp,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: FittedBox(
                      child: Text(
                        'Make Call',
                        style: GoogleFonts.openSans(
                          fontSize: 14.0.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
