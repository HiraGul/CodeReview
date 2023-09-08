import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class RequiredFieldLabel extends StatelessWidget {
  final Color? textColor;
  final String title;
  final bool isRequired;

  const RequiredFieldLabel({
    Key? key,
    this.textColor,
    this.isRequired = true,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: context.locale.languageCode == 'en'
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: RichText(
        text: TextSpan(
            text: title,
            style: GoogleFonts.openSans(fontSize: 16.sp, color: labelColor),
            children: [
              isRequired
                  ? TextSpan(
                      text: '  *',
                      style: GoogleFonts.openSans(
                          fontSize: 16.sp, color: redColor),
                    )
                  : const TextSpan()
            ]),
      ),
    );
  }
}
