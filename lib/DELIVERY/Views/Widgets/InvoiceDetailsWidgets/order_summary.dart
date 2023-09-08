import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/price.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/sub_total.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/tax_amount.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/row_widget.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/PdfVoucher/pdf_controller.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: ListView(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: 382.0.sp,
            height: 40.0.sp,
            padding: EdgeInsets.only(left: 21.sp),
            color: const Color(0xFFF6F6F6),
            child: Align(
              alignment: MySharedPrefs.getLocale()!
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(
                'Order Summary'.tr(),
                style: GoogleFonts.openSans(
                  fontSize: 16.0.sp,
                  color: const Color(0xFF111111),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(
                left: 21.sp, right: 21.sp, top: 10.sp, bottom: 10.sp),
            children: [
              RowWidget(
                title: 'Delivery Charges'.tr(),
                widget2: Text(
                  'FREE Delivery'.tr(),
                  style: GoogleFonts.openSans(
                    fontSize: 12.0.sp,
                    color: const Color(0xFF4F7491),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Divider(color: Colors.grey),
              RowWidget(
                title: "Tax Amount".tr(),
                widget2: BlocBuilder<TaxAmountCubit, double>(
                  builder: (context, state) {
                    PdfVoucherController.vat = state.toStringAsFixed(2);
                    return Text.rich(
                      TextSpan(
                        style: GoogleFonts.openSans(
                          fontSize: 13.0.sp,
                          color: const Color(0xFF888888),
                        ),
                        children: [
                          const TextSpan(
                            text: '',
                          ),
                          TextSpan(
                            text: '${state.toStringAsFixed(2)} SAR',
                            style: GoogleFonts.openSans(
                              color: const Color(0xFF111111),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    );
                  },
                ),
              ),
              RowWidget(
                title: "Sub Total".tr(),
                widget2: BlocBuilder<SubTotalCubit, double>(
                  builder: (context, state) {
                    PdfVoucherController.subTotal = state.toStringAsFixed(2);
                    return Text(
                      '${state.toStringAsFixed(2)} SAR',
                      style: GoogleFonts.openSans(
                        fontSize: 13.0.sp,
                        color: const Color(0xFF111111),
                      ),
                      textAlign: TextAlign.right,
                    );
                  },
                ),
              ),
              const Divider(color: Colors.grey),
              RowWidget(
                title: "Price".tr(),
                widget2: BlocBuilder<PriceCubit, double>(
                  builder: (context, state) {
                    PdfVoucherController.price = state.toStringAsFixed(2);
                    OrderDetailsController.orderTotalPrice =
                        double.parse(state.toStringAsFixed(2));
                    return Text(
                      '${state.toStringAsFixed(2)} SAR',
                      style: GoogleFonts.openSans(
                        fontSize: 16.0.sp,
                        color: const Color(0xFFF89321),
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
