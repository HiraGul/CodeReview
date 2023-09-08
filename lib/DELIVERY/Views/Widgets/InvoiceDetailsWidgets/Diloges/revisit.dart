import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderRevisitCubit/order_revisit_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/RevisitReasonCubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/not_delivered.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/Buttons/not_delivered_dialog_button.dart';

class RevisitDialog extends StatefulWidget {
  const RevisitDialog({Key? key}) : super(key: key);

  @override
  State<RevisitDialog> createState() => _RevisitDialogState();
}

class _RevisitDialogState extends State<RevisitDialog> {
  final List<GroupModel> _group = [
    GroupModel(text: "${"Reason".tr()} 1", selected: true),
    GroupModel(text: "${"Reason".tr()} 2", selected: false),
    GroupModel(text: "${"Reason".tr()} 3", selected: false),
  ];

  Widget makeRadioTiles() {
    List<Widget> list = <Widget>[];

    for (int i = 0; i < _group.length; i++) {
      list.add(BlocBuilder<RevisitReason, String?>(
        builder: (context, state) {
          return RadioListTile(
            value: _group[i].text,
            groupValue: state,
            selected: _group[i].selected,
            onChanged: (val) {
              BlocProvider.of<RevisitReason>(context).selectReason(reason: val);
            },
            activeColor: AppColors.primaryColor,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Align(
                alignment: Alignment.centerLeft,
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
    return Container(
      width: 414.0.sp,
      height: 366.0.sp,
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
                  alignment: Alignment.center,
                  child: Text(
                    'Reason to not deliver'.tr(),
                    style: GoogleFonts.openSans(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w700),
                  ),
                ),

                /// Cross Button to Close the Dialog
                ///
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  color: Colors.red,
                  iconSize: 35.0,
                  icon: Icon(
                    Icons.close_rounded,
                    size: 24.sp,
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
          BlocBuilder<RevisitReason, String?>(
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.sp),
                child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<OrderRevisitCubit>(context).orderRevisit(
                          orderId: OrderDetailsController
                              .orderDetailModel!.data!.id
                              .toString(),
                          reason: state!);
                    },
                    child: OrderStatusButton(
                      buttonStatus: 4,
                      title: 'Submit',
                    )),
              );
            },
          ),
        ],
      ),
    );
  }
}
