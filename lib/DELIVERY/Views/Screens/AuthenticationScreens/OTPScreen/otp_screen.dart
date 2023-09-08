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
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_pin_text_field.dart';
import 'package:tojjar_delivery_app/Localization/language_dropdown.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/snackbar.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              height: 95.sp,
            ),
            Center(
              child: Text(
                "Enter OTP".tr(),
                style: GoogleFonts.openSans(
                    fontSize: 28.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 3.sp,
            ),
            Text(
              "Please enter OTP from your provided mobile \n number to verify your account"
                  .tr(),
              style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 28.sp,
            ),
            CustomPinTextField(
              controller: pinController,
            ),
            SizedBox(
              height: 54.sp,
            ),

            /// verify otp button
            BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordLoaded) {
                  Navigator.pushNamed(
                    context,
                    Strings.changePasswordScreen,
                    arguments: pinController.text,
                  );
                }
                if (state is ResetPasswordError) {
                  showMessageSnackBar(context, state.error);
                }
                if (state is ResetPasswordNoInternet) {
                  showMessageSnackBar(context, "Weak or no internet");
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is ResetPasswordLoading) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 48.sp),
                    height: 50.sp,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.sp,
                      ),
                    ),
                    child: loadingIndicator(
                      dotColor: Colors.white,
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 48.sp),
                    child: CustomButton(
                        iconCheck: 3,
                        onTap: () {
                          context.read<ResetPasswordCubit>().verifyOtp(
                                otp: pinController.text,
                              );
                        },
                        title: "Verify OTP".tr(),
                        buttonColor: AppColors.primaryColor,
                        textColor: AppColors.whiteColor),
                  );
                }
              },
            ),
            SizedBox(
              height: 170.sp,
            ),
            SvgPicture.asset(Images.poweredByJMM),
          ],
        ),
      ),
    );
  }
}
