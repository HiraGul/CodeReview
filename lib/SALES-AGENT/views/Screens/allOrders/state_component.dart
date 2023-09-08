import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';

import '../payLaterRequestView/components/title_row_cell_component.dart';

class StateComponent extends StatelessWidget {
  const StateComponent({super.key, required this.state});
  final Widget state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: FlexColumnWidth(70.sp),
              1: FlexColumnWidth(100.sp),
              2: FlexColumnWidth(100.sp),
              3: FlexColumnWidth(100.sp),
              4: FlexColumnWidth(80.sp)
            },
            border: TableBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.sp)),
                top: BorderSide(color: loginBtnColor, width: 0.2.sp),
                left: BorderSide(color: loginBtnColor, width: 0.2.sp),
                right: BorderSide(color: loginBtnColor, width: 0.2.sp),
                bottom: BorderSide(color: loginBtnColor, width: 0.2.sp)),
            children: [
              TableRow(
                  decoration: const BoxDecoration(
                    color: lightGray,
                  ),
                  children: [
                    TitleRowCellComponent(
                        text: 'Order Number'.tr(), height: 60.sp),
                    TitleRowCellComponent(
                        text: "Order Placed Date".tr(), height: 60.sp),
                    TitleRowCellComponent(
                        text: 'Order Total(Inclusive Price)'.tr(),
                        height: 60.sp),
                    TitleRowCellComponent(
                        text: 'Order Status'.tr(), height: 60.sp),
                    TitleRowCellComponent(text: 'Details'.tr(), height: 60.sp),
                  ]),
            ],
          ),
          150.ph,
          state
        ],
      ),
    );
  }
}
