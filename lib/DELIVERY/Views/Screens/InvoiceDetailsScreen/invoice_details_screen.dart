import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CheckPartialPayRequest/check_partial_pay_request_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CheckPayLaterCubit/check_pay_later_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AppBar/appbar.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/buttons_widget.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/invoice_details_card_widget.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/invoice_details_items_builder.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/select_all_widget.dart';

import '../../Widgets/InvoiceDetailsWidgets/order_summary.dart';

class InvoiceDetailScreen extends StatefulWidget {
  const InvoiceDetailScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  init() async {
    context.read<CheckPayLaterCubit>().checkPayLater(
        orderId: OrderDetailsController.orderDetailModel.data.id.toString());
    context.read<CheckPartialPayRequestCubit>().createPartialPaymentRequest(
        orderId: OrderDetailsController.orderDetailModel.data.id.toString());
  }

  @override
  void initState() {
    init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      bottomNavigationBar: const InvoiceDetailsButtonWidget(),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 17.sp, vertical: 17.sp),
          shrinkWrap: true,
          children: [
            /// back to pick orders button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: buildAppBar(
                  title: "Back to Picked Orders".tr(),
                  context: context,
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ),

            /// customer details information widget
            const InvoiceDetailsCardWidget(),
            SizedBox(
              height: 10.sp,
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Note :  ".tr(),
                  style: GoogleFonts.openSans(
                    fontSize: 14.0,
                    color: const Color(0xFFEA3829),
                  ),
                ),
                TextSpan(
                  text:
                      "Unselected items will be saved as returned \n\t\t \t\t\t\t\t\t\t\t\t items against this order."
                          .tr(),
                  style: GoogleFonts.openSans(
                    fontSize: 14.0,
                    color: const Color(0xFF013861),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 10.sp,
            ),

            /// select all functionality InCase user wants to select all orders

            const SelectAllProductsWidgets(),

            ///Items
             ItemBuilder(),

            /// summary widget
            const OrderSummaryWidget(),
          ],
        ),
      ),
    );
  }
}
