import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CreatePartialPaymentRequest/create_partial_paymenr_request_cubit_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/deliveries_length.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/price.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderStatusCubit/order_status_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/PartialPaymentNotificationCubit/partial_payment_notification_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/partial_payment_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/order_detail_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/order_history_sharedprefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SignatureScreen/signature_partial_pay.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_button.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/Dialoges/otp_dialog.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/SignatureScreenWidgets/columnWidgetCard.dart';
import 'package:tojjar_delivery_app/commonWidgets/FlutterToast.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';

class PartialPaymentDialog extends StatefulWidget {
  const PartialPaymentDialog({Key? key}) : super(key: key);

  @override
  State<PartialPaymentDialog> createState() => _PartialPaymentDialogState();
}

class _PartialPaymentDialogState extends State<PartialPaymentDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 414.0.sp,
      height: MediaQuery.of(context).viewInsets.bottom == 0 ? 432.sp : 0.9.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(6.0.r),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.16),
            offset: const Offset(0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Container(
            width: 2.sw,
            height: 60.0.sp,
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6.0),
                ),
                color: Colors.grey.shade200),

            /// Title Of the Reason to NOt Deliver Dialog
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Text
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Partial Pay Request'.tr(),
                    style: GoogleFonts.openSans(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w700),
                  ),
                ),

                /// Cross Button to Close the Dialog

                IconButton(
                  onPressed: () => Navigator.pop(context),
                  color: AppColors.brightRedColor,
                  iconSize: 35.0,
                  icon: Icon(
                    Icons.close_rounded,
                    size: 24.sp,
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            height: 20.sp,
          ),
          // Group: Group 160552

          ColumnWidget(
            title: 'Customer Name'.tr(),
            value: OrderDetailsController
                    .orderDetailModel.data.shippingAddress?.name ??
                "",
          ),
          Row(
            children: [
              Expanded(
                child: BlocBuilder<DeliveriesLength, int?>(
                  builder: (context, state) {
                    return ColumnWidget(
                      title: 'No of Items'.tr(),
                      value: state!.toString(),
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<PriceCubit, double?>(
                  builder: (context, state) {
                    return ColumnWidget(
                      title: 'Total bill (SAR)'.tr(),
                      value: state.toString(),
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ColumnWidget(
                  title: 'Driver Name'.tr(),
                  value: MySharedPrefs.getUser()?.user?.name ?? "",
                ),
              ),
              Expanded(
                child: ColumnWidget(
                  title: 'Enter Amount'.tr(),
                  value: 'textField',
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 20.sp),
            child: BlocConsumer<CreatePartialPaymenrRequestCubitCubit,
                CreatePartialPaymenrRequestCubitState>(
              listener: (context, state) {
                if (state is CreatePartialPaymenrRequestCubitCreated) {
                  for (int i = 0;
                      i < OrderDetailsController.deliveredOrderList.length;
                      i++) {
                    OrderDetailsController.products!.add(Product(
                      id: OrderDetailsController
                          .deliveredOrderList[i].product!.id,
                      name: OrderDetailsController
                          .deliveredOrderList[i].quantity
                          .toString(),
                    ));
                  }

                  OrderHistoryModelSharedPrefs orderHistoryModelSharedPrefs =
                      OrderHistoryModelSharedPrefs(
                          id: OrderDetailsController.orderDetailModel.data.id,
                          grandTotal: OrderDetailsController
                              .orderDetailModel.data.grandTotal,
                          products: OrderDetailsController.products);

                  MySharedPrefs.setOrderData(orderHistoryModelSharedPrefs);
                  print("per Quantity Tax");
                  print(OrderDetailsController
                      .deliveredOrderList[0].perQuantityTax);
                  OrderHistoryModelSharedPrefs? orderHistory =
                      MySharedPrefs.getOrderData();
                  print("Shared pref Partial Pay ");
                  print(orderHistory?.grandTotal);
                  print(orderHistory?.id);

                  partialPayController.clear();
                  BlocProvider.of<PartialPaymentNotificationCubit>(context)
                      .partialPaymentNotification(
                          saleAgentId: PartialPaymentController
                                  .partialPaymentModel?.data.saleAgentId
                                  .toString() ??
                              '');
                  showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SignaturePartialPay(
                                          orderId: OrderDetailsController
                                              .orderDetailModel.data.id
                                              .toString())),
                              ModalRoute.withName(
                                  Strings.invoiceDetailsScreen));
                        });
                        return CustomDialog(
                            iconColor: AppColors.greenColor,
                            title: 'Partial Pay Request Send',
                            icon: Images.checkCircleYellow,
                            titleStyle: GoogleFonts.openSans(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.greenColor,
                            ),
                            descriptionStyle: GoogleFonts.openSans(
                              fontSize: 14.sp,
                              color: AppColors.greyColor,
                            ),
                            description:
                                'Request for partial pay has been send successfully');
                      });
                  // Navigator.of(context).pop();
                }
                if (state is CreatePartialPaymenrRequestCubitFailed) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(state.myErrorModel.message),
                          content: Text(state.myErrorModel.description ?? ''),
                          actions: [
                            CustomButton(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                iconCheck: 0,
                                title: 'OK',
                                buttonColor: AppColors.primaryColor,
                                textColor: Colors.white)
                          ],
                        );
                      });
                }
              },
              builder: (context, state) {
                if (state is CreatePartialPaymenrRequestCubitCreating) {
                  return SizedBox(
                    height: 55.sp,
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                } else {
                  return partialPayController.text.isNotEmpty
                      ? CustomButton(
                          onTap: () {
                            if (double.parse(OrderDetailsController
                                    .orderDetailModel.data.grandTotal
                                    .toString()) <=
                                double.parse(partialPayController.text)) {
                              flutterSnackBar(context,
                                  'Entered amount must be less than the total bill');
                            } else {
                              BlocProvider.of<OrderStatus>(context)
                                  .changeStatus(0);

                              context
                                  .read<CreatePartialPaymenrRequestCubitCubit>()
                                  .createPartialPaymentRequest(
                                      orderId: OrderDetailsController
                                          .orderDetailModel.data.id
                                          .toString(),
                                      orderAmount: partialPayController.text);
                            }
                          },
                          iconCheck: 3,
                          title: 'Send Partial Payment Request',
                          buttonColor: AppColors.primaryColor,
                          textColor: AppColors.whiteColor,
                        )
                      : CustomButton(
                          onTap: () {},
                          iconCheck: 3,
                          title: 'Send Partial Payment Request',
                          buttonColor: AppColors.greyColor,
                          textColor: AppColors.whiteColor,
                        );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
