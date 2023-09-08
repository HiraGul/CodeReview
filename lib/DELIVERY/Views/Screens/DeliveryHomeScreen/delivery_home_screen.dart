import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderStatusCubit/order_status_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderSummaryCubit/order_summary_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderSummaryCubit/order_summary_state.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_summary_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/PickedAssignedOrders/picked_assigned_orders.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_button.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/delivery_status_card.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/logout.dart';
import 'package:tojjar_delivery_app/Localization/language_cubit.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/error_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/no_internet.dart';

import '../../../../SALES-AGENT/utils/app_colors.dart';
import '../../../../SALES-AGENT/views/widgets/my_text.dart';

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  @override
  void initState() {
    BlocProvider.of<OrdersCubit>(context).getOrdersCubit();
    context.read<OrderSummaryCubit>().fetchOrderSummary();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: BlocBuilder<LoginSelectLanguageCubit, String>(
          builder: (context, state) {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () async {
                await context.read<OrderSummaryCubit>().fetchOrderSummary();
              },
              child: ListView(
                padding: EdgeInsets.all(17.sp),
                children: [
                  SizedBox(
                    height: 0.1.sh,
                  ),
                  InkWell(
                      onTap: () {
                        showAlertDialog(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.login_rounded),
                          SizedBox(
                            width: 5.sp,
                          ),
                          MyText(
                            text: "Log out".tr(),
                            size: 16.sp,
                            color: textDarkColor,
                          ),
                        ],
                      )),

                  /// Delivery Dashboard

                  Center(
                    child: Text(
                      "Delivery Dashboard".tr(),
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w900, fontSize: 28.sp),
                    ),
                  ),
                  Text(
                    "Today's Delivery Status".tr(),
                    style: GoogleFonts.cairo(
                      fontSize: 18.0,
                      color: Colors.black,
                      height: 1.78,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  BlocBuilder<OrderSummaryCubit, OrderSummaryState>(
                    builder: (context, state) {
                      if (state is OrderSummaryLoadingState) {
                        return Padding(
                          padding: EdgeInsets.only(top: 0.3.sh),
                          child: Center(child: loadingIndicator()),
                        );
                      }

                      if (state is OrderSummaryErrorState) {
                        return CustomErrorStateIndicator(
                          onTap: () {
                            context
                                .read<OrderSummaryCubit>()
                                .fetchOrderSummary();
                          },
                        );
                      }
                      if (state is OrderSummaryNoInternetState) {
                        return NoInternetWidget(
                          onTap: () {
                            context
                                .read<OrderSummaryCubit>()
                                .fetchOrderSummary();
                          },
                        );
                      }
                      return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 20.sp,
                          ),
                          DeliveryStatusCard(
                            title: "All Orders".tr(),
                            value: (orderSummaryModelController.data.cancelled +
                                    orderSummaryModelController.data.pickedUp +
                                    orderSummaryModelController
                                        .data.partialDelivered +
                                    orderSummaryModelController.data.pending +
                                    orderSummaryModelController.data.onHold +
                                    orderSummaryModelController
                                        .data.rescheduled +
                                    orderSummaryModelController.data.revisit +
                                    orderSummaryModelController.data.delivered +
                                    orderSummaryModelController.data.onTheWay)
                                .toString(),
                            leadingIcon: Images.allOrders,
                          ),

                          SizedBox(
                            height: 20.sp,
                          ),

                          /// Delivered button
                          DeliveryStatusCard(
                            title: "Delivered".tr(),
                            value: orderSummaryModelController.data.delivered
                                .toString(),
                            leadingIcon: Images.deliver,
                          ),
                          SizedBox(
                            height: 0.3.sh,
                          ),

                          /// view all assigned orders
                          CustomButton(
                              iconCheck: 3,
                              onTap: () {
                                if (OrderModelController
                                    .startedDeliveries.data.isEmpty) {
                                  BlocProvider.of<OrderStatus>(context)
                                      .changeStatus(0);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AssignedAndPickedOrders(
                                                pageValue: 0,
                                              )));
                                } else {
                                  BlocProvider.of<OrderStatus>(context)
                                      .changeStatus(2);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AssignedAndPickedOrders(
                                                pageValue: 2,
                                              )));
                                }
                              },
                              title: "View Assigned Orders".tr(),
                              buttonColor: AppColors.primaryColor,
                              textColor: AppColors.whiteColor),
                          SizedBox(
                            height: 0.1.sh,
                          ),
                          // SvgPicture.asset(Images.poweredByJMM)
                        ],
                      );
                    },
                  ),

                  //
                ],
              ),
            );
          },
        ));
  }
}
