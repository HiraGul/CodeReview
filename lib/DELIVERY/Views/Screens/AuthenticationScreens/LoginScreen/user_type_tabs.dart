import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/login_controllers.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/text_style.dart';

class UserTypeTabs extends StatefulWidget {
  const UserTypeTabs({Key? key}) : super(key: key);

  @override
  State<UserTypeTabs> createState() => _UserTypeTabsState();
}

class _UserTypeTabsState extends State<UserTypeTabs> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80.sp,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              AuthControllers.userType = 'sale_agent';
              setState(() {});
            },
            child: Container(
              height: 110.sp,
              width: 110.sp,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AuthControllers.userType == 'sale_agent'
                        ? AppColors.primaryColor
                        : AppColors.greyColor,
                  ),
                  borderRadius: BorderRadius.circular(20.sp)),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      Images.saleAgent,
                      color: AuthControllers.userType == 'sale_agent'
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Sale Agent'.tr(),
                      style: AppTextStyles.textStyle(
                          context: context,
                          fontSize: 18.sp,
                          color: AuthControllers.userType == 'sale_agent'
                              ? AppColors.primaryColor
                              : AppColors.greyColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.sp,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              AuthControllers.userType = 'delivery_boy';
              setState(() {});
            },
            child: Container(
              height: 110.sp,
              width: 110.sp,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AuthControllers.userType == 'delivery_boy'
                        ? AppColors.primaryColor
                        : AppColors.greyColor,
                  ),
                  borderRadius: BorderRadius.circular(20.sp)),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      Images.lDriver,
                      color: AuthControllers.userType == 'delivery_boy'
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Delivery boy'.tr(),
                      style: AppTextStyles.textStyle(
                          context: context,
                          fontSize: 18.sp,
                          color: AuthControllers.userType == 'delivery_boy'
                              ? AppColors.primaryColor
                              : AppColors.greyColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 80.sp,
        ),
      ],
    );
  }
}
