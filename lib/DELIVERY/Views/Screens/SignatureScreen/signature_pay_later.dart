import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CheckPayLaterCubit/check_pay_later_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/check_box_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/price.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/PayLaterNotificationCubit/pay_later_notification_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/delivered_cubit/delivered_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/delivered_cubit/select_all_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/pay_later_repo.dart';
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

class ESignaturePayLaterScreen extends StatefulWidget {
  final String orderId;
  final bool? isTerminatedState;

  const ESignaturePayLaterScreen(
      {required this.orderId, Key? key, this.isTerminatedState})
      : super(key: key);

  @override
  State<ESignaturePayLaterScreen> createState() =>
      _ESignaturePayLaterScreenState();
}

class _ESignaturePayLaterScreenState extends State<ESignaturePayLaterScreen> {
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
    // OrderHistoryModelSharedPrefs orderHistoryModelSharedPrefs =
    //     OrderHistoryModelSharedPrefs(
    //         id: 22, grandTotal: 300.0, orderDetails: []);
    //
    // MySharedPrefs.setOrderData(orderHistoryModelSharedPrefs);
    // print("Shared Prefs");
    // print(MySharedPrefs.getOrderData());
    //
    // OrderHistoryModelSharedPrefs? orderHistory = MySharedPrefs.getOrderData();
    // print("Shared Prefs Object");
    // print(orderHistory?.id);
    // print(orderHistory?.grandTotal);
    // print(orderHistory!.orderDetails?.length);
    //
    // OrderDetailsController.orderDetailModel.data.id = orderHistory.id;
    // OrderDetailsController.deliveredOrderList = orderHistory.orderDetails!;
    // OrderDetailsController.orderTotalPrice = orderHistory.grandTotal!;
    // print("Controller Data");
    // print(OrderDetailsController.orderDetailModel.data.id);
    // print(OrderDetailsController.deliveredOrderList.length);
    // print(OrderDetailsController.orderTotalPrice);

    context.read<CheckPayLaterCubit>().checkPayLater(orderId: widget.orderId);
    if (widget.isTerminatedState == true) {
      OrderHistoryModelSharedPrefs? orderHistory = MySharedPrefs.getOrderData();
      OrderDetailsController.orderDetailModel.data.id = orderHistory?.id;
      OrderDetailsController.products = orderHistory!.products;
      OrderDetailsController.orderTotalPrice = orderHistory.grandTotal;
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
      bottomNavigationBar: BlocBuilder<CheckPayLaterCubit, CheckPayLaterState>(
        builder: (context, state) {
          return PayLaterRepo.payLetterStatus != 1
              ? BlocListener<PayLaterNotificationCubit,
                  PayLaterNotificationState>(
                  listener: (context, state) {
                    if (state is PayLaterNotificationSuccess) {
                      showMessageSnackBar(context,
                          "Notification successfully send to sale agent".tr());
                    }
                    if (state is PayLaterNotificationNoInternet) {
                      showMessageSnackBar(
                          context,
                          "Please check your Internet connection and try again"
                              .tr());
                    }
                    if (state is PayLaterNotificationFailed) {
                      showMessageSnackBar(
                          context,
                          "Notification did not successfully send to sale agent"
                              .tr());
                    }
                  },
                  child: BlocBuilder<PriceCubit, double>(
                    builder: (context, state) {
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
                      OrderDetailsController.deliveredOrderList.clear();
                      OrderDetailsController.items.clear();
                      PayLaterRepo.payLetterStatus == 'null';
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
                      return BlocBuilder<SelectSingleProductCubit, List<bool>>(
                        builder: (context, singleProduct) {
                          return BlocBuilder<SelectAllCubit, bool>(
                            builder: (context, isSelectedAll) {
                              return BlocBuilder<PriceCubit, double>(
                                builder: (context, state) {
                                  return ReachedButtonWidget(
                                    title: "Delivered".tr(),
                                    onTap: () async {
                                      OrderDetailsController.items.clear();
                                      var body = await _controller.toPngBytes();
                                      String base64String = '';

                                      if (body != null) {
                                        base64String = base64.encode(body);
                                      }

                                      for (var data in OrderDetailsController
                                          .deliveredOrderList) {
                                        var map = {
                                          'product_id': data.productId,
                                          'quantity': data.quantity,
                                        };
                                        OrderDetailsController.items.add(map);
                                      }

                                      Map<String, dynamic> data =
                                          base64String != ''
                                              ? {
                                                  "order_id":
                                                      OrderDetailsController
                                                          .orderDetailModel
                                                          .data
                                                          .id
                                                          .toString(),
                                                  "payment_type": 'pay_later',
                                                  "items":
                                                      OrderDetailsController
                                                          .items,
                                                  "order_total":
                                                      OrderDetailsController
                                                          .orderTotalPrice,
                                                  "customer_signature":
                                                      base64String.toString(),
                                                }
                                              : {
                                                  "order_id":
                                                      OrderDetailsController
                                                          .orderDetailModel
                                                          .data
                                                          .id
                                                          .toString(),
                                                  "payment_type": 'pay_later',
                                                  "items":
                                                      OrderDetailsController
                                                          .items,
                                                  "order_total":
                                                      OrderDetailsController
                                                          .orderTotalPrice
                                                };

                                      if (context.mounted) {
                                        context
                                            .read<DeliveredCubit>()
                                            .getDeliver(
                                              deliveryData: data,
                                            );
                                      }
                                    },
                                    buttonColor: AppColors.primaryColor,
                                  );
                                },
                              );
                            },
                          );
                        },
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
          child: BlocBuilder<CheckPayLaterCubit, CheckPayLaterState>(
            builder: (context, state) {
              if (state is CheckPayLaterLoading) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (state is CheckPayLaterNoInternet) {
                return NoInternetWidget(
                  onTap: () {
                    context
                        .read<CheckPayLaterCubit>()
                        .checkPayLater(orderId: widget.orderId);
                  },
                );
              } else if (state is CheckPayLaterError) {
                return CustomErrorStateIndicator(
                  onTap: () {
                    context
                        .read<CheckPayLaterCubit>()
                        .checkPayLater(orderId: widget.orderId);
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
                            if (PayLaterRepo.payLetterStatus == -1) {
                              Navigator.pushNamed(
                                  context, Strings.signatureScreen);
                            } else {
                              Navigator.pushNamed(
                                  context, Strings.deliveryDetailsScreen);
                            }
                            // }
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
                            "Pay Later Request Response".tr(),
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
                              alignment: MySharedPrefs.getLocale()!
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
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
                                      PayLaterRepo.payLetterStatus == 0
                                          ? "Pending".tr()
                                          : PayLaterRepo.payLetterStatus == 1
                                              ? "Accepted".tr()
                                              : "Rejected".tr(),
                                      style: GoogleFonts.openSans(
                                        fontSize: 14.0.sp,
                                        color: PayLaterRepo.payLetterStatus == 0
                                            ? const Color(0xFFF89321)
                                            : PayLaterRepo.payLetterStatus == 1
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
                                          .read<CheckPayLaterCubit>()
                                          .checkPayLater(
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
