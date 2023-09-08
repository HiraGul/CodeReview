import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/price.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/SIgnatureHideCubit/signature_hide.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/pay_later_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AppBar/appbar.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/DeliveryDetailsWidget/bottom_nav_button.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/SignatureScreenWidgets/signature_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/FlutterToast.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';

import '../../../Controllers/Cubits/delivered_cubit/delivered_cubit.dart';
import '../../Widgets/SignatureScreenWidgets/radio_files.dart';

class ESignatureScreen extends StatefulWidget {
  const ESignatureScreen({Key? key}) : super(key: key);

  @override
  State<ESignatureScreen> createState() => _ESignatureScreenState();
}

class _ESignatureScreenState extends State<ESignatureScreen> {
  /// Signature Controller
  final SignatureController _controller = SignatureController(
      penStrokeWidth: 2,

      /// signature pen color
      penColor: Colors.black,

      /// signature background color when exported!
      exportBackgroundColor: Colors.white,
      onDrawStart: () {},
      onDrawEnd: () {});

  @override
  void initState() {
    BlocProvider.of<SignatureHideCubit>(context).signatureHide(signature: true);
    super.initState();

    /// Signature Controller pen stroke width and Pen Color
    _controller.addListener(() => print('Value changed'));
  }

  @override
  void dispose() {
    /// here dispose the controller fo the signature
    _controller.dispose();
    super.dispose();
  }

  TextEditingController paymentMethod =
      TextEditingController(text: 'cash_on_delivery');

  ValueNotifier isDisableDeliveryButton = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: BlocConsumer<DeliveredCubit, DeliveredState>(
        listener: (context, state) {
          if (state is DeliveredLoaded) {
            PayLaterRepo.payLetterStatus == 'null';
            OrderDetailsController.deliveredOrderList.clear();
            OrderDetailsController.orderTotalPrice = 0.0;
            BlocProvider.of<OrdersCubit>(context).getOrdersCubit();
            Navigator.pushNamed(context, Strings.summaryScreen);
            OrderDetailsController.items.clear();
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
            return BlocBuilder<PriceCubit, double>(
              builder: (context, state) {
                return ValueListenableBuilder(
                  valueListenable: isDisableDeliveryButton,
                  builder: (context,isDisabled, child) {
                    return ReachedButtonWidget(
                      isDisabled: isDisabled,
                      title: "Delivered".tr(),
                      onTap: () async {
                        OrderDetailsController.items.clear();
                        var body = await _controller.toPngBytes();
                        String base64String = '';

                        if (body != null) {
                          base64String = base64.encode(body);
                        }

                        for (var data
                            in OrderDetailsController.deliveredOrderList) {
                          var map = {
                            'product_id': data.productId,
                            'quantity': data.quantity,
                          };
                          OrderDetailsController.items.add(map);
                        }

                        Map<String, dynamic> data = base64String != ''
                            ? {
                                "order_id": OrderDetailsController
                                    .orderDetailModel.data.id
                                    .toString(),
                                "payment_type": paymentMethod.text.toString(),
                                "items": OrderDetailsController.items,
                                "order_total":
                                    OrderDetailsController.orderTotalPrice,
                                "customer_signature": base64String.toString(),
                              }
                            : {
                                "order_id": OrderDetailsController
                                    .orderDetailModel.data.id
                                    .toString(),
                                "payment_type": paymentMethod.text.toString(),
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
                );
              },
            );
          }
        },
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 10.sp,
              ),
              Expanded(
                child: buildAppBar(
                    title: "Back To Order Details".tr(),
                    context: context,
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ),
              Expanded(
                  flex: 6,
                  child: SplashScreenRadioButtons(
                    disableDeliveredButton: isDisableDeliveryButton,
                    paymentMethod: paymentMethod,
                  )),
              Expanded(
                  flex: 8,
                  child: SignatureSection(signatureController: _controller)),
            ],
          ),
        ),
      ),
    );
  }
}
