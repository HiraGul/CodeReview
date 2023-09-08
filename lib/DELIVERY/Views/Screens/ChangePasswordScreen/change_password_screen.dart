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

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

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
              height: 50.sp,
            ),
            SvgPicture.asset(
              Images.logo,
              height: 80.sp,
            ),
            SizedBox(
              height: 56.sp,
            ),
            Center(
              child: Text(
                "Change Password".tr(),
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
              "Enter your new password below to get \n your login access".tr(),
              style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 37.sp,
            ),
            titleText("New Password".tr()),
            SizedBox(
              height: 6.sp,
            ),

            /// custom text field for changing password
            Container(
                padding: EdgeInsets.only(left: 48.sp, right: 42.sp),
                child: CustomTextField(
                    hintText: '123456', controller: newPasswordController)),
            SizedBox(
              height: 22.sp,
            ),
            titleText("Confirm Password".tr()),
            SizedBox(
              height: 6.sp,
            ),
            Container(
                padding: EdgeInsets.only(left: 48.sp, right: 42.sp),
                child: CustomTextField(
                    hintText: '123456', controller: confirmPasswordController)),
            SizedBox(
              height: 28.sp,
            ),
            BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) async {
                if (state is ResetPasswordNoInternet) {
                  showMessageSnackBar(context, "Weak or no internet".tr());
                }
                if (state is ResetPasswordLoaded) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          title: "Password Change Successfully!".tr(),
                          icon: Images.checkCircle,
                          titleStyle: GoogleFonts.openSans(
                            fontSize: 18.sp,
                            color: AppColors.greenColor,
                          ),
                          description: 'You can now login with new password',
                          iconColor: AppColors.greenColor,
                          descriptionStyle: GoogleFonts.openSans(
                            fontSize: 14.0,
                            color: const Color(0xFF707070),
                          ),
                        );
                      });

                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Strings.splashScreen, (route) => false);
                }
                if (state is ResetPasswordError) {
                  showMessageSnackBar(context, state.error);
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
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (confirmPasswordController.text ==
                            newPasswordController.text) {
                          final otp =
                              ModalRoute.of(context)!.settings.arguments;
                          ;

                          context.read<ResetPasswordCubit>().resetPassword(
                              otp: otp.toString(),
                              confirmPassword: confirmPasswordController.text);
                        } else {
                          showMessageSnackBar(
                              context, "Password does not match".tr());
                        }
                      },
                      title: "Confirm Changes".tr(),
                      buttonColor: AppColors.primaryColor,
                      textColor: AppColors.whiteColor,
                      iconCheck: 3,
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 120.sp,
            ),
            SvgPicture.asset(Images.poweredByJMM),
          ],
        ),
      ),
    );
  }

  titleText(title) {
    return Container(
      padding: EdgeInsets.only(left: 50.sp),
      child: Text(
        title,
        style: GoogleFonts.openSans(
          color: AppColors.greyColor,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
