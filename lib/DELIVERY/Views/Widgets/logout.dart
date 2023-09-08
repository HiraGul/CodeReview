import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/logoutCubit/logout_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/logoutCubit/logout_state.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/login_controllers.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/message.dart';
import 'package:tojjar_delivery_app/commonWidgets/list_lenth_loading.dart';

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "No".tr(),
      style: GoogleFonts.openSans(
          color: AppColors.greyColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: BlocListener<DriverLogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutLoadedState) {
          Navigator.popAndPushNamed(context, Strings.splashScreen);

          showMessage(context,
              AuthControllers.logoutModelController.message.toString().tr());
        }
        if (state is LogoutNoInternetState) {
          Navigator.of(context).pop();
          showMessage(context, "No Internet Connection".tr());
        }
        if (state is LogoutNoDataState) {
          Navigator.of(context).pop();
          showMessage(context, "Page Not Found".tr());
        }
        if (state is LogoutErrorState) {
          Navigator.of(context).pop();
          showMessage(context, state.error);
        }
      },
      child: BlocBuilder<DriverLogoutCubit, LogoutState>(
        builder: (context, state) {
          if (state is LogoutLoadingState) {
            return listLoadingIndicator(color: AppColors.redColor);
          }
          return Text(
            "Yes".tr(),
            style: GoogleFonts.openSans(
                color: AppColors.redColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          );
        },
      ),
    ),
    onPressed: () {
      context.read<DriverLogoutCubit>().userLogout();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Logout".tr(),
      style: GoogleFonts.openSans(
          color: AppColors.blackColor,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold),
    ),
    content: Text(
      "Do you want to logout?".tr(),
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
