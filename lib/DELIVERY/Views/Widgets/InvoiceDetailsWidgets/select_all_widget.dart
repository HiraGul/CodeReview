import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/checkBox_widget.dart';

class SelectAllProductsWidgets extends StatelessWidget {
  const SelectAllProductsWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 382.0.sp,
      height: 48.0.sp,
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      color: const Color(0xFFF6F6F6),
      child: Row(
        children: [
          OrderDetailsController.orderDetailModel.data.orderDetails!.isEmpty ||
                  OrderDetailsController
                          .orderDetailModel.data.orderDetails!.length ==
                      1
              ? const Spacer(
                  flex: 3,
                )
              : Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      const CheckBoxWidget(
                        myEnum: CheckBoxEnum.orderDetailSelectAll,
                      ),
                      SizedBox(
                        width: 20.sp,
                      ),
                      Expanded(
                          flex: 2,
                          child: Align(
                            alignment: MySharedPrefs.getLocale()!
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Text(
                              'Select All'.tr(),
                              style: GoogleFonts.openSans(
                                fontSize: 12.0,
                                color: const Color(0xFF474747),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
          Expanded(
              flex: 5,
              child: Align(
                alignment: MySharedPrefs.getLocale()!
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Text(
                  '${"Item".tr()} ${OrderDetailsController.orderDetailModel.data.orderDetails!.length}',
                  style: GoogleFonts.openSans(
                    fontSize: 12.0,
                    color: const Color(0xFF474747),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )),
          Expanded(
              child: Align(
            alignment: MySharedPrefs.getLocale()!
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text(
              'Qty'.tr(),
              style: GoogleFonts.openSans(
                fontSize: 12.0.sp,
                color: const Color(0xFF474747),
                fontWeight: FontWeight.w700,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
