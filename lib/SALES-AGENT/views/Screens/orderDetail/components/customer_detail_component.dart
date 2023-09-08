import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';

import '../../../../utils/app_colors.dart';
import '../../../widgets/info_detail_row.dart';
import '../../../widgets/my_text.dart';

class ComponentDetailComponent extends StatelessWidget {
  const ComponentDetailComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.sp, right: 30.sp),
      child: Column(
        children: [
          Align(
            alignment: context.locale.languageCode == "en"
                ? Alignment.topLeft
                : Alignment.topRight,
            child: MyText(
              text: "Customer Details".tr(),
              size: 16.sp,
              weight: FontWeight.bold,
              color: textMediumColor,
            ),
          ),
          15.ph,
          InfoDetailRow(
              tag: "Full Name".tr(),
              info: orderDetailModelController!.orders!.customerDetails!.name),
          12.ph,
          InfoDetailRow(
              tag: 'Phone Number'.tr(),
              info:
                  orderDetailModelController!.orders!.customerDetails!.phone ??
                      ''),
          12.ph,
          InfoDetailRow(
              tag: 'Email'.tr(),
              info: orderDetailModelController!.orders!.customerDetails!.email),
          12.ph,
          InfoDetailRow(
              tag: 'Id Number'.tr(),
              info: orderDetailModelController!
                      .orders!.customerDetails!.idNumber ??
                  '')
        ],
      ),
    );
  }
}
