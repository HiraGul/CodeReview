import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/MapScreen/view_map.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_button.dart';

class MapAndDeliveryButtons extends StatelessWidget {
  final PageController controller;

  const MapAndDeliveryButtons({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.sp, vertical: 20.sp),
      height: 180.sp,
      width: 100.sp,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.kDisableButtonColor),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kDisableButtonColor.withOpacity(0.16),
            offset: const Offset(0, 3.0),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.sp),
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
            child: CustomButton(
              iconCheck: 1,
              isIcon: Images.map,
              onTap: () {
                BlocProvider.of<OrdersCubit>(context).getOrdersCubit();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewMapScreen(controller: controller)));
              },
              title: 'View Map'.tr(),
              buttonColor: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ),
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 10.sp),
          //   padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
          //   child: CustomButton(
          //     iconCheck: 3,
          //     onTap: () {
          //       BlocProvider.of<OrderStatus>(context).changeStatus(0);
          //       controller.jumpToPage(0);
          //     },
          //     title: 'Stop Delivery'.tr(),
          //     buttonColor: AppColors.greyColor,
          //     textColor: AppColors.whiteColor,
          //   ),
          // ),
        ],
      ),
    );
  }
}
