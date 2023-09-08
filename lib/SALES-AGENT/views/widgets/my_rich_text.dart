import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class MyRichText extends StatelessWidget {
  const MyRichText(
      {super.key,
      required this.firstText,
      required this.secondText,
      required this.firstSize,
      required this.secondSize,
      required this.firstWeight,
      required this.secondWeight,
      required this.firstColor,
      required this.secondColor});

  final String firstText;
  final String secondText;
  final double firstSize;
  final double secondSize;
  final FontWeight firstWeight;
  final FontWeight secondWeight;
  final Color firstColor;
  final Color secondColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: firstText,
            style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: firstSize,
                fontWeight: firstWeight),
            children: [
          TextSpan(
              text: "  ($secondText)",
              style: GoogleFonts.openSans(
                  color: loginBtnColor,
                  fontSize: secondSize,
                  fontWeight: FontWeight.bold))
        ]));
  }
}
