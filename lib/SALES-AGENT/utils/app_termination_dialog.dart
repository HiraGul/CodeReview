import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

showTerminationDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "No",
      style: GoogleFonts.openSans(
          color: AppColors.greyColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      Navigator.of(context).pop();
      Future.value(false);
    },
  );
  Widget continueButton = TextButton(
    child: Text(
      "Yes",
      style: GoogleFonts.openSans(
          color: AppColors.redColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      Future.value(true);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Exit App",
      style: GoogleFonts.openSans(
          color: AppColors.blackColor,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold),
    ),
    content: Text(
      "Do you want to Exit?",
      style: GoogleFonts.openSans(
          color: AppColors.blackColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w400),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
