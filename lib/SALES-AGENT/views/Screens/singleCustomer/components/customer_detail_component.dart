import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/info_detail_row.dart';

class CustomerDetailComponent extends StatelessWidget {
  const CustomerDetailComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoDetailRow(
          tag: "Full Name".tr(),
          info: customerDetailModelController!.customer?.name ?? '',
          infoColor: Colors.black,
        ),
        12.ph,
        InfoDetailRow(
          tag: 'Phone Number'.tr(),
          info: customerDetailModelController!.customer?.phone ?? '',
          infoColor: Colors.black,
        ),
        12.ph,
        InfoDetailRow(
          tag: 'Secondary Phone Number'.tr(),
          info: customerDetailModelController!.customer?.secondaryPhone ?? '',
          infoColor: Colors.black,
        ),
        12.ph,
        InfoDetailRow(
          tag: 'Email'.tr(),
          info: customerDetailModelController!.customer?.email ?? '',
          infoColor: Colors.black,
        ),
        12.ph,
        InfoDetailRow(
          tag: 'ID Number'.tr(),
          info: customerDetailModelController!.customer?.idNumber ?? '',
          infoColor: Colors.black,
        ),
        12.ph,
        InfoDetailRow(
          tag: 'Shop Name'.tr(),
          info: customerDetailModelController!.customer?.shopName ?? '',
          infoColor: Colors.black,
        ),
        12.ph,
        InfoDetailRow(
          tag: 'Shop type'.tr(),
          info: customerDetailModelController!.customer?.shopType ?? '',
          infoColor: Colors.black,
        ),
        12.ph,
        InfoDetailRow(
          tag: 'Shop Address'.tr(),
          info: customerDetailModelController!.customer?.shopAddress ?? '',
          infoColor: Colors.black,
        ),
        12.ph,
        InfoDetailRow(
          tag: 'District Name'.tr(),
          info: customerDetailModelController!.customer?.district ?? '',
          infoColor: Colors.black,
        ),
        12.ph,
        InfoDetailRow(
          tag: 'VAT'.tr(),
          info: customerDetailModelController!.customer?.vatNumber ?? '',
          infoColor: Colors.black,
        ),
      ],
    );
  }
}
