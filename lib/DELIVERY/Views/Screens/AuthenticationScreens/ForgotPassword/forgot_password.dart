import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_button.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_text_field.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/Dialoges/otp_dialog.dart';
import 'package:tojjar_delivery_app/Localization/language_dropdown.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/snackbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneNumberController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 17.sp),
          children: [
            SizedBox(
              height: 40.sp,
              width: 1.sw,
              child: Row(
                children: [
                  const Spacer(
                    flex: 4,
                  ),

                  /// Language dropdown
                  Expanded(
                    flex: 3,
                    child: AuthenticationLanguageDropDownButton(
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 110.sp,
            ),
            SvgPicture.asset(Images.logo),
            SizedBox(
              height: 42.sp,
            ),
            Center(
              child: Text(
                'Forgot Password'.tr(),
                style: GoogleFonts.openSans(
                    fontSize: 28.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 13.sp,
            ),
            Text(
              'Please enter the mobile number below to \n get OTP'.tr(),
              style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 28.sp,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.sp),
              child: Text(
                'Phone Number'.tr(),
                style: GoogleFonts.openSans(
                  color: AppColors.greyColor,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(
              height: 6.sp,
            ),
            Container(
                padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
                child: CustomTextField(
                    hintText: 'Enter Phone Number'.tr(),
                    controller: phoneNumberController)),
            SizedBox(
              height: 28.sp,
            ),

            /// send OTP button
            BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) async {
                if (state is ResetPasswordLoaded) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                            iconColor: AppColors.orangeColor,
                            title: 'Send OTP',
                            icon: Images.checkCircleYellow,
                            titleStyle: GoogleFonts.openSans(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.orangeColor,
                            ),
                            descriptionStyle: GoogleFonts.openSans(
                              fontSize: 14.sp,
                              color: AppColors.greyColor,
                            ),
                            description:
                                'OTP has been sent to provided mobile number'
                                    .tr());
                      });
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.of(context).pop();
                  await Future.delayed(const Duration(milliseconds: 200));

                  Navigator.pushNamed(context, Strings.otpScreen);
                }
                if (state is ResetPasswordError) {
                  showMessageSnackBar(context, state.error);
                }
                if (state is ResetPasswordNoInternet) {
                  showMessageSnackBar(context, 'Weak or no internet'.tr());
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is ResetPasswordLoading) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.sp),
                    height: 50.sp,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.sp,
                      ),
                    ),
                    child: loadingIndicator(dotColor: Colors.white),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.only(
                      left: 40.sp,
                      right: 40.sp,
                    ),
                    child: CustomButton(
                        iconCheck: 3,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (phoneNumberController.text.isEmpty) {
                            showMessageSnackBar(
                                context, 'Please enter phone number'.tr());
                          } else {
                            context.read<ResetPasswordCubit>().sendOtp(
                                phoneNumber: phoneNumberController.text);
                          }
                        },
                        title: 'Send OTP'.tr(),
                        buttonColor: AppColors.primaryColor,
                        textColor: AppColors.whiteColor),
                  );
                }
              },
            ),
            SizedBox(
              height: 180.sp,
            ),
            SvgPicture.asset(Images.poweredByJMM),
          ],
        ),
      ),
    );
  }
}
