import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/print_button.dart';

import '../DeliveryDetailsWidget/make_call_widget.dart';
import '../OrdersScreensWidgets/customer_shop_widget.dart';
import '../PdfVoucher/pdf.dart';

class InvoiceDetailsCardWidget extends StatelessWidget {
  const InvoiceDetailsCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: 382.0.sp,
      decoration: const BoxDecoration(
        color: Color(0xFFECF7FF),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE1E1E1),
            offset: Offset(0, -0.5),
            blurRadius: 0,
          ),
        ],
      ),
      child: ListView(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 17.sp),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.sp),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: MySharedPrefs.getLocale()!
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      '${'Invoice ID:'.tr()}  ${OrderDetailsController.orderDetailModel.data.id} ',
                      style: GoogleFonts.openSans(
                        fontSize: 16.0,
                        color: const Color(0xFF001E33),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.sp,
                ),
                Expanded(
                    child: Align(
                  alignment: MySharedPrefs.getLocale()!
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      GenerateVoucherPDF.generateVoucherPdfFile(
                          buildContext: context);
                    },
                    child: const PrintWidget(),
                  ),
                ))
              ],
            ),
          ),
          Align(
            alignment: MySharedPrefs.getLocale()!
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.sp),
              child: Text(
                '${"Date".tr()} : ${OrderDetailsController.orderDetailModel.data.date!}',
                style: GoogleFonts.poppins(
                  fontSize: 11.0.sp,
                  color: const Color(0xFF444444),
                  fontWeight: FontWeight.w300,
                  height: 2.73,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.sp),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                      child: CustomerShopWidget(
                    title: 'Customer Name'.tr(),
                    value: OrderDetailsController
                        .orderDetailModel.data.shippingAddress!.name
                        .toString(),
                  )),
                ),
                Expanded(
                  child: CustomerShopWidget(
                    title: 'Shop Name'.tr(),
                    value: OrderDetailsController
                        .orderDetailModel.data.shippingAddress!.shopName
                        .toString(),
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                  child: MakeCallWidget(
                    phoneNumber: OrderDetailsController
                        .orderDetailModel.data.shippingAddress!.phone
                        .toString(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(3.0.sp),
              ),
              color: const Color(0xFFF8F8F8),
            ),
            child: Column(
              children: [
                Align(
                  alignment: MySharedPrefs.getLocale()!
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    'Shop Address'.tr(),
                    style: GoogleFonts.openSans(
                      fontSize: 14.0.sp,
                      color: const Color(0xFF707070),
                    ),
                  ),
                ),
                Align(
                  alignment: MySharedPrefs.getLocale()!
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    OrderDetailsController
                        .orderDetailModel.data.shippingAddress!.address
                        .toString(),
                    style: GoogleFonts.openSans(
                      fontSize: 16.0.sp,
                      color: AppColors.blackColor,
                      height: 1.25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
