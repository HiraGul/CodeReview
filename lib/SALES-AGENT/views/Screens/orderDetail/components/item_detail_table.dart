import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/dataController/data_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../widgets/my_text.dart';

class ItemDetailTable extends StatelessWidget {
  const ItemDetailTable({super.key});

  // var list = ;

  @override
  Widget build(BuildContext context) {
    return Table(
        // columnWidths: {
        //   0: FlexColumnWidth(60.sp),
        //   1: FlexColumnWidth(80.sp),
        //   2: FlexColumnWidth(90.sp),
        //   3: FlexColumnWidth(80.sp),
        //   4: FlexColumnWidth(80.sp),
        //   5: FlexColumnWidth(80.sp),
        //   6: FlexColumnWidth(90.sp)
        // },
        children: List.generate(
            orderDetailModelController!.orders!.items!.length + 1,
            (index) => index == 0
                ? TableRow(
                    decoration: const BoxDecoration(color: lightGray),
                    children: [
                        Container(
                            alignment: Alignment.center,
                            height: 50.sp,
                            child: MyText(
                              text: 'S.No'.tr(),
                              size: 12.sp,
                              color: labelColor,
                            )),
                        Container(
                            alignment: Alignment.center,
                            height: 50.sp,
                            child: MyText(
                              textAlign: TextAlign.center,
                              text: 'Item Name'.tr(),
                              size: 12.sp,
                              color: labelColor,
                            )),
                        Container(
                            alignment: Alignment.center,
                            height: 50.sp,
                            child: MyText(
                              textAlign: TextAlign.center,
                              text: 'Item Category'.tr(),
                              size: 12.sp,
                              color: labelColor,
                            )),
                        Container(
                            alignment: Alignment.center,
                            height: 50.sp,
                            child: MyText(
                              textAlign: TextAlign.center,
                              text: 'Brand Name'.tr(),
                              size: 12.sp,
                              color: labelColor,
                            )),
                        Container(
                            alignment: Alignment.center,
                            height: 50.sp,
                            child: MyText(
                              textAlign: TextAlign.center,
                              text: 'Unit Price'.tr(),
                              size: 12.sp,
                              color: labelColor,
                            )),
                        Container(
                            alignment: Alignment.center,
                            height: 50.sp,
                            child: MyText(
                              textAlign: TextAlign.center,
                              text: 'Quantity'.tr(),
                              size: 12.sp,
                              color: labelColor,
                            )),
                        Container(
                            alignment: Alignment.center,
                            height: 50.sp,
                            child: MyText(
                              textAlign: TextAlign.center,
                              text: 'Total Amount'.tr(),
                              size: 12.sp,
                              color: labelColor,
                            )),
                      ])
                : TableRow(children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50.sp,
                        child: MyText(
                          text: orderDetailModelController!
                              .orders!.items![index - 1].sNo
                              .toString(),
                          size: 12.sp,
                        )),
                    Container(
                        alignment: Alignment.center,
                        height: 50.sp,
                        child: MyText(
                          textAlign: TextAlign.center,
                          text: orderDetailModelController!
                              .orders!.items![index - 1].name!,
                          size: 12.sp,
                        )),
                    Container(
                        alignment: Alignment.center,
                        height: 50.sp,
                        child: MyText(
                          textAlign: TextAlign.center,
                          text: orderDetailModelController!
                              .orders!.items![index - 1].category
                              .toString(),
                          size: 12.sp,
                        )),
                    Container(
                        alignment: Alignment.center,
                        height: 50.sp,
                        child: MyText(
                          textAlign: TextAlign.center,
                          text: orderDetailModelController!
                                  .orders!.items![index - 1].brandName ??
                              '',
                          size: 12.sp,
                        )),
                    Container(
                        alignment: Alignment.center,
                        height: 50.sp,
                        child: MyText(
                          textAlign: TextAlign.center,
                          text: orderDetailModelController!
                              .orders!.items![index - 1].unitPrice!
                              .toString(),
                          size: 12.sp,
                        )),
                    Container(
                        alignment: Alignment.center,
                        height: 50.sp,
                        child: MyText(
                          textAlign: TextAlign.center,
                          text: orderDetailModelController!
                              .orders!.items![index - 1].quantity!
                              .toString(),
                          size: 12.sp,
                        )),
                    Container(
                        alignment: Alignment.center,
                        height: 50.sp,
                        child: MyText(
                          textAlign: TextAlign.center,
                          text: orderDetailModelController!
                              .orders!.items![index - 1].totalAmount!
                              .toString(),
                          size: 12.sp,
                        )),
                  ])));
  }
}
