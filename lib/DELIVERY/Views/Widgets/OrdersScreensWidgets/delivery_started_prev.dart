import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CheckPartialPayRequest/check_partial_pay_request_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CheckPayLaterCubit/check_pay_later_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/DeliveryStartedAnimationCubit/animation_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/DriverOrderDetailsCubit/order_details_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/customer_shop_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/empty_state.dart';
import 'package:tojjar_delivery_app/commonWidgets/error_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/no_internet.dart';

class DeliveryStartedPrevious extends StatefulWidget {
  final PageController controller;

  const DeliveryStartedPrevious({required this.controller, Key? key})
      : super(key: key);

  @override
  State<DeliveryStartedPrevious> createState() =>
      _DeliveryStartedPreviousState();
}

class _DeliveryStartedPreviousState extends State<DeliveryStartedPrevious> {
  @override


  getData()async{

await Future.delayed(Duration(milliseconds: 50));
    BlocProvider.of<AnimationCubit>(context).changeStatus(true);

    context.read<OrdersCubit>().getOrdersCubit();

  }
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        print("State of orderCubit is $state");
        if (state is OrdersLoading) {
          return Center(child: loadingIndicator());
        }
        if (state is OrdersException) {
          return CustomErrorStateIndicator(
            onTap: () {
              BlocProvider.of<OrdersCubit>(context).getOrdersCubit();
            },
          );
        }
        if (state is OrdersSocketException) {
          return NoInternetWidget(
            onTap: () {
              BlocProvider.of<OrdersCubit>(context).getOrdersCubit();
            },
          );
        }
        return OrderModelController.startedDeliveries.data.isEmpty
            ? const EmptyData()
            : ListView.builder(
                padding: EdgeInsets.only(bottom: 0.2.sh, top: 10.sp),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: OrderModelController.startedDeliveries.data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.read<CheckPayLaterCubit>().checkPayLater(
                          orderId: OrderModelController
                              .startedDeliveries.data[index].id
                              .toString());
                      context
                          .read<CheckPartialPayRequestCubit>()
                          .createPartialPaymentRequest(
                              orderId: OrderModelController
                                  .startedDeliveries.data[index].id
                                  .toString());

                      BlocProvider.of<OrderDetailsCubit>(context)
                          .getOrderDetailsCubit(
                              orderId: OrderModelController
                                  .startedDeliveries.data[index].id
                                  .toString());
                      Navigator.pushNamed(
                          context, Strings.deliveryDetailsScreen);
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 17.sp, vertical: 10.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0.r),
                          color: Colors.white,
                          border: Border.all(
                              width: 0.7.r, color: const Color(0xffE6E6E6)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.05),
                              offset: const Offset(0, 0),
                              blurRadius: 15.0,
                            ),
                          ],
                        ),
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            ListView(
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.sp, vertical: 10.sp),
                              shrinkWrap: true,
                              children: [
                                // Group: Group 160314

                                Align(
                                  alignment: MySharedPrefs.getLocale()!
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Text(
                                    '${'Invoice ID:'.tr()} ${OrderModelController.startedDeliveries.data[index].id}',
                                    style: GoogleFonts.openSans(
                                      fontSize: 16.0.sp,
                                      color: const Color(0xFF001E33),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: MySharedPrefs.getLocale()!
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Text(
                                    '${'Date'.tr()} ${OrderModelController.startedDeliveries.data[index].orderDate}',
                                    style: GoogleFonts.cairo(
                                      fontSize: 11.0.sp,
                                      color: const Color(0xFF444444),
                                      fontWeight: FontWeight.w300,
                                      height: 2.73,
                                    ),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                          child: CustomerShopWidget(
                                        title: 'Customer Name'.tr(),
                                        value: OrderModelController
                                            .startedDeliveries
                                            .data[index]
                                            .customerName
                                            .toString(),
                                      )),
                                    ),
                                    const Spacer(),
                                    Expanded(
                                      child: CustomerShopWidget(
                                        title: 'Shop Name'.tr(),
                                        value: OrderModelController
                                            .startedDeliveries
                                            .data[index]
                                            .address
                                            .shopName
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 120.sp,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.sp, vertical: 10.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(3.0.r),
                                  ),
                                  color: const Color(0xFFF8F8F8),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  MySharedPrefs.getLocale()!
                                                      ? Alignment.centerLeft
                                                      : Alignment.centerRight,
                                              child: Text(
                                                'Drop Off'.tr(),
                                                style: GoogleFonts.cairo(
                                                  fontSize: 14.0.sp,
                                                  color:
                                                      const Color(0xFF707070),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  MySharedPrefs.getLocale()!
                                                      ? Alignment.centerLeft
                                                      : Alignment.centerRight,
                                              child: Text(
                                                OrderModelController
                                                    .startedDeliveries
                                                    .data[index]
                                                    .address
                                                    .address
                                                    .toString(),
                                                style: GoogleFonts.openSans(
                                                  fontSize: 16.0.sp,
                                                  color: AppColors.blackColor,
                                                  height: 1.25,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.sp,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Align(
                                                      alignment: MySharedPrefs
                                                              .getLocale()!
                                                          ? Alignment.centerLeft
                                                          : Alignment
                                                              .centerRight,
                                                      child: SvgPicture.asset(
                                                          Images.timer))),
                                              const Spacer(),
                                              Expanded(
                                                flex: 10,
                                                child: Align(
                                                  alignment:
                                                      MySharedPrefs.getLocale()!
                                                          ? Alignment.centerLeft
                                                          : Alignment
                                                              .centerRight,
                                                  child: Text(
                                                    '${OrderModelController.deliveryStartedDistance[index].distance} ${OrderModelController.deliveryStartedKmDistance[index].distance}',
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 12.0.sp,
                                                      color: const Color(
                                                          0xFF707171),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    // Expanded(
                                    //     child: InkWell(
                                    //   onTap: () async {
                                    //     var lat = 33.9746;
                                    //
                                    //     var lan = 71.4732;
                                    //     var uri = Uri.parse(
                                    //         "google.navigation:q=$lat,$lan&mode=d");
                                    //     if (await canLaunch(uri.toString())) {
                                    //       print("TRUE");
                                    //       await launch(uri.toString());
                                    //     } else {
                                    //       throw 'Could not launch ${uri.toString()}';
                                    //     }
                                    //   },
                                    //   child: Row(
                                    //     children: [
                                    //       const Expanded(
                                    //           child: Icon(Icons.map)),
                                    //       Expanded(
                                    //         child: Align(
                                    //           alignment:
                                    //               MySharedPrefs.getLocale()!
                                    //                   ? Alignment.centerLeft
                                    //                   : Alignment.centerRight,
                                    //           child: Text(
                                    //             'View map',
                                    //             style: GoogleFonts.openSans(
                                    //               fontSize: 12.0.sp,
                                    //               color:
                                    //                   const Color(0xFF001E33),
                                    //               fontWeight: FontWeight.w700,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  );
                });
      },
    );
  }
}
