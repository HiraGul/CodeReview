import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle textStyle(
      {required BuildContext context,
      required Color color,
      required double fontSize,
      required FontWeight? fontWeight}) {
    return GoogleFonts.openSans(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
