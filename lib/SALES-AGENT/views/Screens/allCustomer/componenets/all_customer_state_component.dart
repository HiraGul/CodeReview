import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';

import '../../payLaterRequestView/components/title_row_cell_component.dart';

class AllCustomerStateComponent extends StatelessWidget {
  const AllCustomerStateComponent({super.key, required this.state});

  final Widget state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 24.sp),
      child: Column(
        children: [
          Table(
            // defaultVerticalAlignment:
            //     TableCellVerticalAlignment.middle,

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
                    TitleRowCellComponent(text: 'Customer'.tr(), height: 50.sp),
                    TitleRowCellComponent(
                        text: "Shop Name".tr(), height: 50.sp),
                    TitleRowCellComponent(text: 'Phone'.tr(), height: 50.sp),
                    TitleRowCellComponent(text: 'Details'.tr(), height: 50.sp),
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
