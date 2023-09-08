import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/ShowPasswordCubit/show_password_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/loginCubit/login_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/loginCubit/login_state.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/text_style.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/AuthenticationScreens/LoginScreen/user_type_tabs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_button.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_text_field.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/message.dart';

import '../../../../Data/DataController/login_controllers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 0.2.sh,
        ),

        Center(
          child: Text(
            'Choose Account Type'.tr(),
            style: AppTextStyles.textStyle(
                context: context,
                fontSize: 20.sp,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),

        /// choose user type
        UserTypeTabs(),

        SizedBox(
          height: 37.sp,
        ),
        Center(
          child: Text(
            'Log In To Tojjar Plus'.tr(),
            style: AppTextStyles.textStyle(
                context: context,
                fontSize: 28.sp,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        titleText('Mobile Number/Email'.tr()),
        SizedBox(
          height: 6.sp,
        ),
        Container(
            padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
            child: CustomTextField(
                hintText: 'Enter Mobile Number/Email'.tr(),
                controller: AuthControllers.phoneNumberController)),
        SizedBox(
          height: 22.sp,
        ),
        titleText('Password'.tr()),
        SizedBox(
          height: 6.sp,
        ),
        BlocBuilder<EyeCubit, bool>(
          builder: (context, state) {
            return Container(
                padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
                child: CustomTextField(
                    obSecure: state,
                    suffixIcon: IconButton(
                        onPressed: () {
                          context.read<EyeCubit>().getIcon(checkIcon: !state);
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: AppColors.primaryColor,
                        )),
                    hintText: 'Enter Password'.tr(),
                    controller: AuthControllers.passwordController));
          },
        ),
        SizedBox(
          height: 20.sp,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Strings.forgotPasswordScreen);
          },
          child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 42.sp),
              child: Text(
                'Forgot Password?'.tr(),
                style: AppTextStyles.textStyle(
                    color: AppColors.greyColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    context: context),
              )),
        ),
        SizedBox(
          height: 50.sp,
        ),

        /// Login button to login user
        BlocListener<DriverLoginCubit, LoginState>(
          listener: (context, state) {
            // if (state is LoginLoadingState) {
            //   showDialog(
            //       context: context,
            //       builder: (context) {
            //         return Dialog(
            //             insetPadding: EdgeInsets.only(bottom: 20.sp),
            //             child: ListView(
            //               shrinkWrap: true,
            //               physics: const NeverScrollableScrollPhysics(),
            //               primary: false,
            //               children: [
            //                 SizedBox(
            //                   height: 30.sp,
            //                 ),
            //                 Center(
            //                     child: CircularProgressIndicator(
            //                   color: AppColors.primaryColor,
            //                 )),
            //                 SizedBox(
            //                   height: 10.sp,
            //                 ),
            //                 Text(
            //                   'Login Please wait...'.tr(),
            //                   textAlign: TextAlign.center,
            //                   style: GoogleFonts.openSans(fontSize: 16.sp),
            //                 ),
            //                 SizedBox(
            //                   height: 30.sp,
            //                 )
            //               ],
            //             ));
            //       });
            // }
            if (state is LoginLoadedState) {
              MySharedPrefs.setUser(AuthControllers.loginModelController!);
              MySharedPrefs.setUserType(AuthControllers.userType!);
              if (AuthControllers.loginModelController!.user!.userType ==
                  'delivery_boy') {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Strings.deliveryHomeScreen,
                    (Route<dynamic> route) => false);
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Strings.saleAgentDashboard,
                    (Route<dynamic> route) => false);
              }
              showMessage(context, "Successfully Login".tr());
            }
            if (state is LoginErrorState) {
              showMessage(context, state.error);
            }
            if (state is LoginTokenExpireState) {
              showMessage(context, 'User is not authorized'.tr());
            }
            if (state is LoginNoInternetState) {
              showMessage(context, "No Internet Connection".tr());
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 48.sp),
            child: CustomButton(
                iconCheck: 3,
                onTap: () {
                  if (AuthControllers.phoneNumberController.text.isNotEmpty &&
                      AuthControllers.passwordController.text.isNotEmpty &&
                      AuthControllers.userType != null) {
                    context.read<DriverLoginCubit>().tojjarLogin();
                  } else {
                    if (AuthControllers.phoneNumberController.text.isEmpty ||
                        AuthControllers.passwordController.text.isEmpty) {
                      showMessage(context,
                          'Please fill all the fields to continue'.tr());
                    } else {
                      showMessage(context, 'Please select user type'.tr());
                    }
                  }
                },
                title: 'Log In'.tr(),
                buttonColor: AppColors.primaryColor,
                textColor: AppColors.whiteColor),
          ),
        ),

        SizedBox(
          height: 20.sp,
        ),
        // SvgPicture.asset(Images.poweredByJMM),
      ],
    );
  }

  titleText(title) {
    return Container(
      padding: EdgeInsets.only(left: 40.sp, right: 40.sp),
      child: Text(
        title,
        style: AppTextStyles.textStyle(
          color: AppColors.greyColor,
          fontSize: 16.sp,
          context: context,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
