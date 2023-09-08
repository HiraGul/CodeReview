import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OnHoldSetDateCubit/on_hold_date_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderResheduleCubit/order_reschedule_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/RescheduledSetDateCubit/new_date_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/Buttons/not_delivered_dialog_button.dart';
import 'package:tojjar_delivery_app/commonWidgets/FlutterToast.dart';

class RescheduledDialog extends StatefulWidget {
  const RescheduledDialog({Key? key}) : super(key: key);

  @override
  State<RescheduledDialog> createState() => _RescheduledDialogState();
}

class _RescheduledDialogState extends State<RescheduledDialog> {
  @override
  Widget build(BuildContext context) {
    TextEditingController reasonController = TextEditingController();
    return Container(
      width: 414.0.sp,
      height: 0.6.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(6.0.r),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.16),
            offset: const Offset(0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: 414.0.sp,
            height: 48.0.sp,
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6.0),
                ),
                color: Colors.grey.shade200),

            /// Title Of the Reason to NOt Deliver Dialog
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Text
                Align(
                  alignment: MySharedPrefs.getLocale()!
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    'Reschedule Order'.tr(),
                    style: GoogleFonts.openSans(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w700),
                  ),
                ),

                /// Cross Button to Close the Dialog

                Align(
                  alignment: MySharedPrefs.getLocale()!
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    color: AppColors.brightRedColor,
                    iconSize: 35.0,
                    icon: Icon(
                      Icons.close_rounded,
                      size: 24.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.sp),
            child: Text(
              'Expected Delivery Date'.tr(),
              style: GoogleFonts.openSans(
                fontSize: 16.0.sp,
                color: const Color(0xFF1C1C1C),
              ),
            ),
          ),
          Container(
            width: 334.0.sp,
            height: 42.0.sp,
            margin: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: Colors.white,
              border: Border.all(
                width: 1.0,
                color: const Color(0xFFDDDDDD),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<OnHoldSetNewDateCubit, DateTime>(
                      builder: (context, state) {
                        return Align(
                          alignment: MySharedPrefs.getLocale()!
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Text(
                            '${state.day} / ${state.month} / ${state.year}',
                            style: GoogleFonts.openSans(
                              fontSize: 16.0.sp,
                              color: const Color(0xFF707171),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: MySharedPrefs.getLocale()!
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: const Icon(
                            Icons.calendar_today_sharp,
                            color: Color(0xFF707171),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.sp),
            child: Text(
              'Reason'.tr(),
              style: GoogleFonts.openSans(
                fontSize: 16.0.sp,
                color: const Color(0xFF1C1C1C),
              ),
            ),
          ),
          Container(
              width: 334.0.sp,
              height: 140.0.sp,
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
              margin: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: const Color(0xFFDDDDDD),
                ),
              ),
              child: TextField(
                  controller: reasonController,
                  cursorColor: AppColors.primaryColor,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Write your Reason'.tr(),
                    hintStyle: GoogleFonts.openSans(
                      fontSize: 14.0.sp,
                      color: const Color(0xFF707171),
                    ),
                    border: InputBorder.none,
                  ))),
          BlocBuilder<RescheduledSetNewDateCubit, DateTime?>(
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.sp),
                child: GestureDetector(
                    onTap: () {
                      if (reasonController.text.isNotEmpty) {
                        BlocProvider.of<OrderRescheduleCubit>(context)
                            .orderRescheduled(
                                orderId: OrderDetailsController
                                    .orderDetailModel.data.id
                                    .toString(),
                                date: state.toString(),
                                reason: reasonController.text);
                      } else {
                        flutterSnackBar(
                            context, "Please Input all Fields".tr());
                      }
                    },
                    child: OrderStatusButton(
                      buttonStatus: 3,
                      title: 'Reschedule'.tr(),
                    )),
              );
            },
          ),
        ],
      ),
    );
  }

  _selectDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            splashColor: Colors.black,
            dialogBackgroundColor: AppColors.whiteColor,
            colorScheme: ColorScheme.light(primary: AppColors.primaryColor)
                .copyWith(
                    primary: AppColors.primaryColor, secondary: Colors.black),
          ),
          child: child ?? const Text(""),
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != DateTime.now()) {
      if (mounted) {
        context.read<RescheduledSetNewDateCubit>().changeStatus(picked);
      }
    }
  }
}
