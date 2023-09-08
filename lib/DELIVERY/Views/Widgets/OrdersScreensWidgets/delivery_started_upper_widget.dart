import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/commonWidgets/list_lenth_loading.dart';

import '../../../Controllers/Cubits/DeliveryStartedAnimationCubit/animation_cubit.dart';

class DeliveryStartedUpperWidget extends StatelessWidget {
  const DeliveryStartedUpperWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.sp,
      child: Stack(
        children: [
          Positioned(
            left: 235.sp,
            right: 0,
            bottom: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.only(right: 10.sp, left: 10.sp),
              height: 58.0.sp,
              width: 207.sp,
              decoration: BoxDecoration(
                color: AppColors.greenColor,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFE1E1E1),
                    offset: Offset(0, -0.5),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: MySharedPrefs.getLocale()!
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: FittedBox(
                        child: Text(
                          'Delivery Started'.tr(),
                          style: GoogleFonts.openSans(
                            fontSize: 14.0,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Align(
                    alignment: MySharedPrefs.getLocale()!
                        ? Alignment.centerRight
                        : Alignment.centerRight,
                    child: CircleAvatar(
                      radius: 16.sp,
                      backgroundColor: AppColors.whiteColor,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.sp),
                        child: Icon(
                          Icons.flag,
                          size: 22.sp,
                          color: AppColors.greenColor,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          BlocBuilder<AnimationCubit, bool>(
            builder: (context, containerPosition) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeInOutCubic,
                left: !containerPosition ? 200.sp : 0.sp,
                right: containerPosition ? 200.sp : 0.sp,
                bottom: 0,
                top: 0,
                child: Container(
                  width: 207.0.sp,
                  height: 58.0.sp,
                  padding: EdgeInsets.only(right: 10.sp, left: 10.sp),
                  decoration: BoxDecoration(
                    color: AppColors.greenColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFE1E1E1),
                        offset: Offset(0, -0.5),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: MySharedPrefs.getLocale()!
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Text(
                            'Picked Order'.tr(),
                            style: GoogleFonts.openSans(
                              fontSize: 14.0,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<OrdersCubit, OrdersState>(
                          builder: (context, state) {
                            if (state is OrdersLoading) {
                              return listLoadingIndicator(color: Colors.white);
                            }
                            return Align(
                              alignment: MySharedPrefs.getLocale()!
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Text(
                                '${OrderModelController.startedDeliveries.data.length}',
                                style: GoogleFonts.openSans(
                                  fontSize: 24.0,
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
