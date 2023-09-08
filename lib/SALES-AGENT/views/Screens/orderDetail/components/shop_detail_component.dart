import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';

import '../../../../data/dataController/data_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../widgets/info_detail_row.dart';
import '../../../widgets/my_text.dart';

class ShopDetailComponent extends StatelessWidget {
  const ShopDetailComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.sp, right: 30.sp),
      child: Column(
        children: [
          Align(
            alignment: context.locale.languageCode == 'en'
                ? Alignment.topLeft
                : Alignment.topRight,
            child: MyText(
              text: "Shop Details".tr(),
              size: 16.sp,
              weight: FontWeight.bold,
              color: textMediumColor,
            ),
          ),
          15.ph,
          InfoDetailRow(
              tag: "Shop Name".tr(),
              info: orderDetailModelController!
                      .orders?.customerDetails?.shopName ??
                  ''),
          12.ph,
          InfoDetailRow(
              tag: 'Shop Address'.tr(),
              info: orderDetailModelController
                      ?.orders?.customerDetails?.address ??
                  ''),
          12.ph,
          InfoDetailRow(
              tag: 'Shop Type'.tr(),
              info: orderDetailModelController
                      ?.orders?.customerDetails?.shopType ??
                  ''),
          12.ph,
          InfoDetailRow(
              tag: 'District Name'.tr(),
              info: orderDetailModelController!
                      .orders!.customerDetails?.districtName ??
                  '')
        ],
      ),
    );
  }
}
