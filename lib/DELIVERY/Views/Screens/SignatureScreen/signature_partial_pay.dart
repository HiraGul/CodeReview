import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CheckPartialPayRequest/check_partial_pay_request_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/price.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/PartialPaymentNotificationCubit/partial_payment_notification_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/delivered_cubit/delivered_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/partial_payment_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/order_history_sharedprefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AppBar/appbar.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/DeliveryDetailsWidget/bottom_nav_button.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/SignatureScreenWidgets/signature_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/FlutterToast.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/error_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/snackbar.dart';

import '../../../../commonWidgets/no_internet.dart';

class SignaturePartialPay extends StatefulWidget {
  final String orderId;
  final bool? isTerminatedState;

  const SignaturePartialPay(
      {required this.orderId, this.isTerminatedState, Key? key})
      : super(key: key);

  @override
  State<SignaturePartialPay> createState() => _SignaturePartialPayState();
}

class _SignaturePartialPayState extends State<SignaturePartialPay> {
  /// Signature Controller
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,

    /// signature pen color
    penColor: Colors.black,

    /// signature background color when exported!
    exportBackgroundColor: Colors.white,
    onDrawStart: () {},
    onDrawEnd: () {},
  );

  @override
  void initState() {
    context
        .read<CheckPartialPayRequestCubit>()
        .createPartialPaymentRequest(orderId: widget.orderId);
    print("SignatureSignature Partial Pay ${widget.orderId}");

    if (widget.isTerminatedState == true) {
      OrderHistoryModelSharedPrefs? orderHistory = MySharedPrefs.getOrderData();
      OrderDetailsController.orderDetailModel.data.id = orderHistory?.id;
      OrderDetailsController.orderTotalPrice = orderHistory?.grandTotal;
      OrderDetailsController.products = orderHistory!.products;
    }

    /// Signature Controller pen stroke width and Pen Color
    _controller.addListener(() => print('Value changed'));

    super.initState();
  }

  @override
  void dispose() {
    /// here dispose the controller fo the signature
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar:
          BlocBuilder<CheckPartialPayRequestCubit, CheckPartialPayRequestState>(
        builder: (context, state) {
          return PartialPaymentRepo.partialStatus != 1
              ? BlocListener<PartialPaymentNotificationCubit,
                  PartialPaymentNotificationState>(
                  listener: (context, state) {
                    if (state is PartialPaymentNotificationSuccess) {
                      showMessageSnackBar(context,
                          "Notification successfully send to sale agent".tr());
                    }
                    if (state is PartialPaymentNotificationNoInternet) {
                      showMessageSnackBar(
                          context,
                          "Please check your Internet connection and try again"
                              .tr());
                    }
                    if (state is PartialPaymentNotificationFailed) {
                      showMessageSnackBar(
                          context,
                          "Notification did not successfully send to sale agent"
                              .tr());
                    }
                  },
                  child: BlocBuilder<PriceCubit, double>(
                    builder: (context, state) {
                      print("Price Cubit partial pay $state");
                      return ReachedButtonWidget(
                        buttonColor: AppColors.disableButton,
                        title: "Delivered".tr(),
                        onTap: () {},
                      );
                    },
                  ),
                )
              : BlocConsumer<DeliveredCubit, DeliveredState>(
                  listener: (context, state) {
                    if (state is DeliveredLoaded) {
                      PartialPaymentRepo.partialStatus == 'null';
                      OrderDetailsController.deliveredOrderList.clear();
                      OrderDetailsController.items.clear();
                      OrderDetailsController.orderTotalPrice = 0.0;
                      BlocProvider.of<OrdersCubit>(context).getOrdersCubit();
                      Navigator.pushNamed(context, Strings.summaryScreen);
                    }
                    if (state is DeliveredError) {
                      flutterSnackBar(context, state.model.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is DeliveredLoading) {
                      return SizedBox(
                        width: 1.sw,
                        height: 150.sp,
                        child: Center(
                          child: loadingIndicator(),
                        ),
                      );
                    } else {
                      return ReachedButtonWidget(
                        title: "Delivered".tr(),
                        onTap: () async {
                          OrderDetailsController.items.clear();
                          var body = await _controller.toPngBytes();
                          String base64String = '';

                          if (body != null) {
                            base64String = base64.encode(body);
                          }
                          if (widget.isTerminatedState == true) {
                            for (var data in OrderDetailsController.products!) {
                              var map = {
                                'product_id': data.id,
                                'quantity': data.name,
                              };
                              OrderDetailsController.items.add(map);
                            }
                          } else {
                            for (var data
                                in OrderDetailsController.deliveredOrderList) {
                              var map = {
                                'product_id': data.productId,
                                'quantity': data.quantity,
                              };
                              OrderDetailsController.items.add(map);
                            }
                          }

                          Map<String, dynamic> data = base64String != ''
                              ? {
                                  "order_id": OrderDetailsController
                                      .orderDetailModel.data.id
                                      .toString(),
                                  "payment_type": 'pay_later',
                                  "items": OrderDetailsController.items,
                                  "order_total":
                                      OrderDetailsController.orderTotalPrice,
                                  "customer_signature": base64String.toString(),
                                }
                              : {
                                  "order_id": OrderDetailsController
                                      .orderDetailModel.data.id
                                      .toString(),
                                  "payment_type": 'pay_later',
                                  "items": OrderDetailsController.items,
                                  "order_total":
                                      OrderDetailsController.orderTotalPrice
                                };

                          if (context.mounted) {
                            context.read<DeliveredCubit>().getDeliver(
                                  deliveryData: data,
                                );
                          }
                        },
                        buttonColor: AppColors.primaryColor,
                      );
                    }
                  },
                );
        },
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BlocBuilder<CheckPartialPayRequestCubit,
              CheckPartialPayRequestState>(
            builder: (context, state) {
              if (state is CheckPartialPayRequestLoading) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (state is CheckPartialPayRequestSocketException) {
                return NoInternetWidget(
                  onTap: () {
                    context
                        .read<CheckPartialPayRequestCubit>()
                        .createPartialPaymentRequest(
                            orderId: OrderDetailsController
                                .orderDetailModel.data.id
                                .toString());
                  },
                );
              } else if (state is CheckPartialPayRequestException) {
                return CustomErrorStateIndicator(
                  onTap: () {
                    context
                        .read<CheckPartialPayRequestCubit>()
                        .createPartialPaymentRequest(
                            orderId: OrderDetailsController
                                .orderDetailModel.data.id
                                .toString());
                  },
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 10.sp,
                    ),
                    Expanded(
                      child: buildAppBar(
                          title: "Back To Payment Method".tr(),
                          context: context,
                          onTap: () {
                            // if (widget.isTerminatedState == true) {
                            //   Navigator.pushNamed(
                            //       context, Strings.deliveryDetailsScreen);
                            // } else {
                            if (PartialPaymentRepo.partialStatus == -1) {
                              Navigator.pushNamed(
                                  context, Strings.signatureScreen);
                            } else {
                              Navigator.pushNamed(
                                  context, Strings.deliveryDetailsScreen);
                            }
                            //}
                          }),
                    ),
                    Expanded(
                      child: Align(
                        alignment: MySharedPrefs.getLocale()!
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.sp,
                          ),
                          child: Text(
                            "Partial Pay Request Response".tr(),
                            style: GoogleFonts.openSans(
                              fontSize: 16.0.sp,
                              color: const Color(0xFF111111),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.sp,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Request Response Status".tr(),
                                style: GoogleFonts.openSans(
                                  fontSize: 16.0,
                                  color: const Color(0xFF111111),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: MySharedPrefs.getLocale()!
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Text(
                                      PartialPaymentRepo.partialStatus == 0
                                          ? "Pending".tr()
                                          : PartialPaymentRepo.partialStatus ==
                                                  1
                                              ? "Accepted".tr()
                                              : "Rejected".tr(),
                                      style: GoogleFonts.openSans(
                                        fontSize: 14.0.sp,
                                        color:
                                            PartialPaymentRepo.partialStatus ==
                                                    0
                                                ? const Color(0xFFF89321)
                                                : PartialPaymentRepo
                                                            .partialStatus ==
                                                        1
                                                    ? AppColors.greenColor
                                                    : AppColors.redColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .read<CheckPartialPayRequestCubit>()
                                          .createPartialPaymentRequest(
                                              orderId: OrderDetailsController
                                                  .orderDetailModel.data.id
                                                  .toString());
                                    },
                                    child: Icon(
                                      Icons.refresh,
                                      color: AppColors.primaryColor,
                                      size: 16.sp,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    // widget.isTerminatedState == true
                    //     ? Expanded(
                    //         child: RichText(
                    //           textAlign: TextAlign.start,
                    //           text: TextSpan(children: [
                    //             const TextSpan(text: "     "),
                    //             TextSpan(
                    //               text: "Note :  ".tr(),
                    //               style: GoogleFonts.openSans(
                    //                 fontSize: 14.0,
                    //                 color: const Color(0xFFEA3829),
                    //               ),
                    //             ),
                    //             TextSpan(
                    //               text:
                    //                   "Please press back button to select items \n\t\t \t\t\t\t\t\t\t\t\t\t\t\t  and then proceed"
                    //                       .tr(),
                    //               style: GoogleFonts.openSans(
                    //                 fontSize: 14.0,
                    //                 color: const Color(0xFF013861),
                    //               ),
                    //             )
                    //           ]),
                    //         ),
                    //       )
                    //     : const Spacer(),
                    Expanded(
                        flex: 10,
                        child:
                            SignatureSection(signatureController: _controller)),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
