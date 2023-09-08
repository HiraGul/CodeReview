import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/NotDeliveredCubit/not_delivered_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/NotDeliveredReasonCubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/not_delivered.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/Buttons/not_delivered_dialog_button.dart';

import '../../../../Data/DataController/order_detail_controller.dart';

class NotDeliveredDialog extends StatefulWidget {
  const NotDeliveredDialog({Key? key}) : super(key: key);

  @override
  State<NotDeliveredDialog> createState() => _NotDeliveredDialogState();
}

class _NotDeliveredDialogState extends State<NotDeliveredDialog> {
  final List<GroupModel> _group = [
    GroupModel(text: "Wrong Location".tr(), selected: false),
    GroupModel(text: "Customer didn't have money".tr(), selected: false),
    GroupModel(text: "Customer didn't order".tr(), selected: false),
    GroupModel(text: "Price not issues".tr(), selected: false),
    GroupModel(text: "Customer didn't want the order".tr(), selected: false),
  ];

  Widget makeRadioTiles() {
    List<Widget> list = <Widget>[];

    for (int i = 0; i < _group.length; i++) {
      list.add(BlocBuilder<NotDeliveredReason, String?>(
        builder: (context, state) {
          return RadioListTile(
            value: _group[i].text,
            groupValue: state,
            selected: _group[i].selected,
            onChanged: (val) {
              // setState(() {
              //   for (int i = 0; i < _group.length; i++) {
              //     _group[i].selected = false;
              //   }
              //   // _value2 = val!;
              //   _group[i].selected = true;
              // });
              BlocProvider.of<NotDeliveredReason>(context)
                  .selectReason(reason: val);
            },
            activeColor: AppColors.primaryColor,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Align(
                alignment: MySharedPrefs.getLocale()!
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Text(
                  _group[i].text,
                  style: GoogleFonts.openSans(
                      fontSize: 17.0.sp, color: AppColors.blackColor),
                ),
              ),
            ),
          );
        },
      ));
    }

    Column column = Column(
      children: list,
    );
    return column;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, updateState) {
        return BlocConsumer<NotDeliveredCubit, NotDeliveredState>(
          listener: (context, state) {
            // if (state is NotDeliveredLoading) {
            //   updateState(() {});
            //   setState(() {});
            // }
          },
          builder: (context, state) {
            return Container(
              width: 414.0.sp,
              height: 490.0.sp,
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
                children: [
                  Container(
                    width: 414.0.sp,
                    height: 50.0.sp,
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
                            'Reason to not deliver'.tr(),
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
                            color: Colors.red,
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
                  Column(
                    children: <Widget>[makeRadioTiles()],
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  BlocBuilder<NotDeliveredReason, String?>(
                    builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<NotDeliveredCubit>(context)
                                  .orderNotDelivered(
                                      orderId: OrderDetailsController
                                          .orderDetailModel.data.id
                                          .toString(),
                                      reason: state!);
                            },
                            child: OrderStatusButton(
                              buttonStatus: 1,
                              title: 'Submit'.tr(),
                            )),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
