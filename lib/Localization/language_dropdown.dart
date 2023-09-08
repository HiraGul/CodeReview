import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/text_style.dart';
import 'package:tojjar_delivery_app/Localization/language_cubit.dart';

final languageList = [
  "English",
  "Arabic",
];

/// Language dropdown cubit

class AuthenticationLanguageDropDownButton extends StatefulWidget {
  final BuildContext context;

  AuthenticationLanguageDropDownButton({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  State<AuthenticationLanguageDropDownButton> createState() =>
      _AuthenticationLanguageDropDownButtonState();
}

class _AuthenticationLanguageDropDownButtonState
    extends State<AuthenticationLanguageDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginSelectLanguageCubit, String>(
      builder: (context, selectLanguage) => DropdownButtonHideUnderline(
        child: Row(
          children: [
            Expanded(
                child: Align(
                    alignment: MySharedPrefs.getLocale() == true
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: const Icon(Icons.language)
                    // SvgPicture.asset(Images.languageIcon)
                    )),
            SizedBox(
              width: 10.sp,
            ),
            Expanded(
              flex: 2,
              child: DropdownButton(
                alignment: Alignment.centerRight,
                iconEnabledColor: AppColors.primaryColor,
                iconDisabledColor: AppColors.disableButton,
                hint: Align(
                  alignment: MySharedPrefs.getLocale() == true
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    selectLanguage.toString().tr(),
                    style: AppTextStyles.textStyle(
                      fontWeight: FontWeight.normal,
                      context: context,
                      fontSize: 16.0.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                isDense: true,
                isExpanded: true,
                autofocus: true,
                onChanged: (language) async {
                  context
                      .read<LoginSelectLanguageCubit>()
                      .selectLanguage(selectLanguage: language.toString());
                  if (language == "English") {
                    await context.setLocale(const Locale('en', 'EN'));
                    setState(() {});
                    // widget.callBack;
                    await MySharedPrefs.setLocale(langLocale: true);
                  } else if (language == "Arabic") {
                    await context.setLocale(const Locale('ar', 'AR'));
                    setState(() {});
                    // widget.callBack;
                    await MySharedPrefs.setLocale(langLocale: false);
                  }
                },
                value: selectLanguage,
                items: languageList
                    .map(
                      (String selectedLanguage) => DropdownMenuItem<String>(
                          value: selectedLanguage,
                          alignment: Alignment.centerRight,
                          child: Align(
                            alignment: MySharedPrefs.getLocale()!
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Text(
                              selectedLanguage.toString().tr(),
                              style: AppTextStyles.textStyle(
                                fontWeight: FontWeight.normal,
                                context: context,
                                fontSize: 16.0.sp,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )),
                    )
                    .toList(),
              ),
            ),
            SizedBox(
              width: 30.sp,
            ),
          ],
        ),
      ),
    );
  }
}
