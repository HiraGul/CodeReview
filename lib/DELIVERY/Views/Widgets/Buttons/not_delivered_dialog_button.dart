import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/NotDeliveredCubit/not_delivered_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderOnHoldCubit/order_on_hold_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderResheduleCubit/order_reschedule_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderRevisitCubit/order_revisit_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderStatusCubit/order_status_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/text_style.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/PickedAssignedOrders/picked_assigned_orders.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/Dialoges/otp_dialog.dart';
import 'package:tojjar_delivery_app/commonWidgets/FlutterToast.dart';

class OrderStatusButton extends StatelessWidget {
  String title;
  int buttonStatus;

  OrderStatusButton({required this.title, required this.buttonStatus, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is OrdersLoaded) {
          if (OrderModelController.startedDeliveries.data.isNotEmpty) {
            BlocProvider.of<OrderStatus>(context).changeStatus(2);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const AssignedAndPickedOrders(
                          pageValue: 2,
                        )),
                (Route<dynamic> route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(context,
                Strings.deliveryHomeScreen, (Route<dynamic> route) => false);
          }
        }
      },
      child: Container(
        height: 50.sp,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColors.primaryColor, width: 1.sp)),
        child:

            /// Not Delivered Cubit state
            buttonStatus == 1
                ? BlocConsumer<NotDeliveredCubit, NotDeliveredState>(
                    listener: (context, state) {
                      if (state is NotDeliveredLoaded) {
                        BlocProvider.of<OrdersCubit>(context).getOrdersCubit();
                        flutterSnackBar(
                          context,
                          state.message,
                        );
                      }
                      if (state is NotDeliveredException) {
                        flutterSnackBar(
                          context,
                          state.error,
                        );
                      }
                      if (state is NotDeliveredSocketException) {
                        flutterSnackBar(
                          context,
                          "Please check your internet connection".tr(),
                        );
                      }
                      if (state is NotDeliveredTokenExpired) {
                        flutterSnackBar(
                            context, "Token Expired Please Login again".tr());
                      }
                    },
                    builder: (context, state) {
                      if (state is NotDeliveredLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      return Container(
                        margin: EdgeInsets.only(left: 10.sp),
                        child: Center(
                          child: Text(
                            title,
                            style: AppTextStyles.textStyle(
                                context: context,
                                fontSize: 18.sp,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    },
                  )

                ///Order On Hold Cubit state
                : buttonStatus == 2
                    ? BlocConsumer<OrderOnHoldCubit, OrderOnHoldState>(
                        listener: (context, state) {
                          if (state is OrderOnHoldLoaded) {
                            BlocProvider.of<OrdersCubit>(context)
                                .getOrdersCubit();
                            flutterSnackBar(
                              context,
                              state.message,
                            );
                          }

                          if (state is OrderOnHoldException) {
                            flutterSnackBar(
                              context,
                              state.error,
                            );
                          }
                          if (state is OrderOnHoldSocketException) {
                            flutterSnackBar(
                              context,
                              "Please check your internet connection".tr(),
                            );
                          }
                          if (state is NotDeliveredTokenExpired) {
                            flutterSnackBar(context,
                                "Token Expired Please Login again".tr());
                          }
                        },
                        builder: (context, state) {
                          if (state is OrderOnHoldLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                          return Container(
                            margin: EdgeInsets.only(left: 10.sp),
                            child: Center(
                              child: Text(
                                title,
                                style: AppTextStyles.textStyle(
                                    context: context,
                                    fontSize: 18.sp,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          );
                        },
                      )

                    /// Order Reschedule Cubit state
                    : buttonStatus == 3
                        ? BlocConsumer<OrderRescheduleCubit,
                            OrderRescheduleState>(
                            listener: (context, state) {
                              if (state is OrderRescheduleLoaded) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                          iconColor: AppColors.greenColor,
                                          title: "Order Rescheduled".tr(),
                                          icon: Images.checkCircleYellow,
                                          titleStyle: GoogleFonts.openSans(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.greenColor,
                                          ),
                                          descriptionStyle:
                                              GoogleFonts.openSans(
                                            fontSize: 14.sp,
                                            color: AppColors.greyColor,
                                          ),
                                          description:
                                              "Order rescheduled successfully"
                                                  .tr());
                                    });
                                Future.delayed(const Duration(seconds: 1), () {
                                  BlocProvider.of<OrdersCubit>(context)
                                      .getOrdersCubit();
                                });
                              }

                              if (state is OrderRescheduleException) {
                                flutterSnackBar(
                                  context,
                                  state.message,
                                );
                              }
                              if (state is OrderRescheduleSocketException) {
                                flutterSnackBar(
                                  context,
                                  "Please check your internet connection".tr(),
                                );
                              }
                              if (state is OrderRescheduleTokenExpired) {
                                flutterSnackBar(context,
                                    "Token Expired Please Login again".tr());
                              }
                            },
                            builder: (context, state) {
                              if (state is OrderRescheduleLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              }
                              return Container(
                                margin: EdgeInsets.only(left: 10.sp),
                                child: Center(
                                  child: Text(
                                    title,
                                    style: AppTextStyles.textStyle(
                                        context: context,
                                        fontSize: 18.sp,
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            },
                          )

                        /// Order Revisit Cubit state
                        : BlocConsumer<OrderRevisitCubit, OrderRevisitState>(
                            listener: (context, state) {
                              if (state is OrderRevisitLoaded) {
                                BlocProvider.of<OrdersCubit>(context)
                                    .getOrdersCubit();
                                flutterSnackBar(context, state.message);
                              }

                              if (state is OrderRevisitException) {
                                flutterSnackBar(
                                  context,
                                  state.message,
                                );
                              }
                              if (state is OrderRevisitSocketException) {
                                flutterSnackBar(
                                  context,
                                  "Please check your internet connection".tr(),
                                );
                              }
                              if (state is OrderRevisitTokenExpired) {
                                flutterSnackBar(context,
                                    "Token Expired Please Login again".tr());
                              }
                            },
                            builder: (context, state) {
                              if (state is OrderRevisitLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              }
                              return Container(
                                margin: EdgeInsets.only(left: 10.sp),
                                child: Center(
                                  child: Text(
                                    title,
                                    style: AppTextStyles.textStyle(
                                        context: context,
                                        fontSize: 18.sp,
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            },
                          ),
      ),
    );
  }
}
