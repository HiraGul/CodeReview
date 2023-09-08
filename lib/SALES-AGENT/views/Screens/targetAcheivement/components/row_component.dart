import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/expand_row_widget.dart';

class RowComponent extends StatelessWidget {
  const RowComponent({super.key, required this.dataKey, required this.data});

  final String dataKey;
  final String data;

  @override
  Widget build(BuildContext context) {
    return ExpandRowWidget(
      item1: dataKey.tr(),
      item2: data,
      item1Color: textLightColor,
      item2Color: textLightColor,
      item1Weight: FontWeight.w500,
      item2Weight: FontWeight.bold,
    );
  }
}
