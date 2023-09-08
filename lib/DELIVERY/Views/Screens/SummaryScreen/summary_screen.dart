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
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/PickedAssignedOrders/picked_assigned_orders.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_button.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/SummaryScreenWidget/summary_card_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/error_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/no_internet.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderSummaryCubit>().fetchOrderSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
      children: [
        SizedBox(
          height: 0.1.sh,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Summary".tr(),
            style: GoogleFonts.openSans(
                fontSize: 21.0.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
              border: Border.all(width: 1.0, color: AppColors.lightGrey),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.05),
                  offset: const Offset(0, 0),
                  blurRadius: 15.0,
                ),
              ],
            ),
            child: BlocBuilder<OrderSummaryCubit, OrderSummaryState>(
              builder: (context, state) {
                if (state is OrderSummaryLoadingState) {
                  return loadingIndicator();
                }

                if (state is OrderSummaryErrorState) {
                  return CustomErrorStateIndicator(
                    onTap: () {
                      context.read<OrderSummaryCubit>().fetchOrderSummary();
                    },
                  );
                }
                if (state is OrderSummaryNoInternetState) {
                  return NoInternetWidget(
                    onTap: () {
                      context.read<OrderSummaryCubit>().fetchOrderSummary();
                    },
                  );
                }
                if (state is OrderSummaryLoadedState) {
                  return ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.sp, vertical: 30.sp),
                    shrinkWrap: true,
                    children: <Widget>[
                      Center(
                          child: Text(
                        "Your Picked Orders are Finished!".tr(),
                        style: GoogleFonts.openSans(
                          fontSize: 16.0.sp,
                          color: const Color(0xFF1AAE56),
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Container(
                        width: 318.0.sp,
                        height: 1.0.sp,
                        color: const Color(0xFFE6E6E6),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),

                      /// Summery widgets
                      buildSummaryColumn(
                          count: orderSummaryModelController.data.delivered,
                          text: "Total Delivered".tr()),
                      buildSummaryColumn(
                          count:
                              orderSummaryModelController.data.partialDelivered,
                          text: "Partial Delivered".tr()),
                      buildSummaryColumn(
                          count: orderSummaryModelController.data.pending,
                          text: "Deliveries Remaining".tr()),
                      buildSummaryColumn(
                          count: orderSummaryModelController.data.onTheWay,
                          text: "On the way".tr()),
                      buildSummaryColumn(
                          count: orderSummaryModelController.data.pickedUp,
                          text: "Picked Up".tr()),
                      buildSummaryColumn(
                          count: orderSummaryModelController.data.rescheduled,
                          text: "Rescheduled".tr()),
                      buildSummaryColumn(
                          count: orderSummaryModelController.data.onHold,
                          text: "On-Hold".tr()),
                      buildSummaryColumn(
                          count: orderSummaryModelController.data.revisit,
                          text: "Revisit".tr()),
                      buildSummaryColumn(
                          count: orderSummaryModelController.data.cancelled,
                          text: "Cancel".tr()),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Container(
                        width: 318.0.sp,
                        height: 1.0.sp,
                        color: const Color(0xFFE6E6E6),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      BlocBuilder<OrdersCubit, OrdersState>(
                        builder: (context, state) {
                          if (state is OrdersLoading) {
                            return loadingIndicator();
                          }
                          return CustomButton(
                            textColor: AppColors.whiteColor,
                            title: "Proceed to Home".tr(),
                            onTap: () async {
                              if (OrderModelController
                                  .startedDeliveries.data.isNotEmpty) {
                                BlocProvider.of<OrderStatus>(context)
                                    .changeStatus(2);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AssignedAndPickedOrders(
                                                pageValue: 2)),
                                    (Route<dynamic> route) => false);
                              } else if (OrderModelController
                                  .assignedOrdersModel.data.isNotEmpty) {
                                BlocProvider.of<OrderStatus>(context)
                                    .changeStatus(1);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AssignedAndPickedOrders(
                                                pageValue: 1)),
                                    (Route<dynamic> route) => false);
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Strings.deliveryHomeScreen,
                                    (Route<dynamic> route) => false);
                              }
                            },
                            iconCheck: 3,
                            buttonColor: AppColors.primaryColor,
                          );
                        },
                      ),
                    ],
                  );
                }

                return SizedBox(
                  height: 0.sp,
                  width: 0.sp,
                );
              },
            )),
      ],
    ));
  }
}
