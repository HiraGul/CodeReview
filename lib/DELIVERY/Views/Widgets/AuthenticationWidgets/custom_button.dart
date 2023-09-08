import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/loginCubit/login_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/loginCubit/login_state.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/text_style.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String title;
  final VoidCallback onTap;
  final String? isIcon;
  final int iconCheck;
  final double? height;
  final Icon? iconData;
  final bool? isDisabled;

  const CustomButton({
    Key? key,
    this.isDisabled,
    required this.onTap,
    required this.iconCheck,
    required this.title,
    required this.buttonColor,
    required this.textColor,
    this.isIcon,
    this.height,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled == true ? null:onTap,
      child: Container(
        height: height ?? 50.sp,
        decoration: BoxDecoration(
            color: isDisabled == true ? Colors.grey: buttonColor,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: buttonColor, width: 1.sp)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconCheck == 1
                ? SvgPicture.asset(isIcon!)
                : iconCheck == 2
                    ? CircleAvatar(
                        radius: 12.sp,
                        backgroundColor: Colors.white,
                        child: iconData)
                    : const SizedBox(),
            BlocBuilder<DriverLoginCubit, LoginState>(
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return const CircularProgressIndicator(
                    color: Colors.white,
                  );
                }
                return Container(
                  margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                  child: Text(
                    title.tr(),
                    style: AppTextStyles.textStyle(
                        context: context,
                        fontSize: 18.sp,
                        color: textColor,
                        fontWeight:
                            iconCheck == 3 ? FontWeight.w600 : FontWeight.w400),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
