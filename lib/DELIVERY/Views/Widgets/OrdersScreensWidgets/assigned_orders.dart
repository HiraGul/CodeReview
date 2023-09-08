import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';

import '../../../../commonWidgets/LoadingWidget.dart';
import '../../../../commonWidgets/empty_state.dart';
import '../../../../commonWidgets/error_widget.dart';
import '../../../../commonWidgets/no_internet.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/images.dart';
import 'customer_shop_widget.dart';

class AssignedOrders extends StatefulWidget {
  const AssignedOrders({Key? key}) : super(key: key);

  @override
  State<AssignedOrders> createState() => _AssignedOrdersState();
}

class _AssignedOrdersState extends State<AssignedOrders> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        print("state is $state");
        if (state is OrdersLoading) {
          return loadingIndicator();
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
        return OrderModelController.assignedOrdersModel.data.isEmpty
            ? const EmptyData()
            : ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 14.sp),
                children: [
                  OrderModelController.assignedOrdersModel.data.isEmpty
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Swipe to pick order'.tr(),
                            style: GoogleFonts.openSans(
                              fontSize: 16.0.sp,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                  ListView.builder(
                      padding: EdgeInsets.only(bottom: 0.1.sh, top: 10.sp),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          OrderModelController.assignedOrdersModel.data.length,
                      itemBuilder: (context, index) {
                        return SwipeTo(
                          onLeftSwipe: () {
                            OrderModelController.pickedOrdersModel.data.add(
                                OrderModelController
                                    .assignedOrdersModel.data[index]);
                            OrderModelController.assignedOrdersModel.data
                                .removeAt(index);

                            OrderModelController.pickedKmDistance
                                .add(OrderModelController.kmDistance[index]);
                            OrderModelController.pickedDistance
                                .add(OrderModelController.distance[index]);
                            OrderModelController.kmDistance.removeAt(index);
                            OrderModelController.distance.removeAt(index);

                            setState(() {});
                          },
                          onRightSwipe: () {
                            OrderModelController.pickedOrdersModel.data.add(
                                OrderModelController
                                    .assignedOrdersModel.data[index]);
                            OrderModelController.assignedOrdersModel.data
                                .removeAt(index);

                            OrderModelController.pickedKmDistance
                                .add(OrderModelController.kmDistance[index]);
                            OrderModelController.pickedDistance
                                .add(OrderModelController.distance[index]);
                            OrderModelController.kmDistance.removeAt(index);
                            OrderModelController.distance.removeAt(index);
                            setState(() {});
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 17.sp, vertical: 10.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0.r),
                                color: Colors.white,
                                border: Border.all(
                                    width: 0.7.r,
                                    color: const Color(0xffE6E6E6)),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.blackColor.withOpacity(0.05),
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
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment:
                                                  MySharedPrefs.getLocale()!
                                                      ? Alignment.centerLeft
                                                      : Alignment.centerRight,
                                              child: Text(
                                                '${'Invoice ID:'.tr()} ${OrderModelController.assignedOrdersModel.data[index].id}',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 16.0.sp,
                                                  color:
                                                      const Color(0xFF001E33),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            child: Container(
                                              alignment:
                                                  MySharedPrefs.getLocale()!
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                              width: 95.8.sp,
                                              height: 24.0.sp,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3.sp),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 1.0,
                                                  color: OrderModelController
                                                              .assignedOrdersModel
                                                              .data[index]
                                                              .deliveryStatus
                                                              .toLowerCase() ==
                                                          'revisit'
                                                      ? AppColors.dullPrimary
                                                      : OrderModelController
                                                                  .assignedOrdersModel
                                                                  .data[index]
                                                                  .deliveryStatus
                                                                  .toLowerCase() ==
                                                              'cancel'
                                                          ? AppColors
                                                              .brightRedColor
                                                          : OrderModelController
                                                                      .assignedOrdersModel
                                                                      .data[
                                                                          index]
                                                                      .deliveryStatus
                                                                      .toLowerCase() ==
                                                                  'on_hold'
                                                              ? AppColors
                                                                  .orangeColor
                                                              : OrderModelController
                                                                          .assignedOrdersModel
                                                                          .data[
                                                                              index]
                                                                          .deliveryStatus
                                                                          .toLowerCase() ==
                                                                      'pending'
                                                                  ? AppColors
                                                                      .greyColor
                                                                  : AppColors
                                                                      .primaryColor,
                                                ),
                                              ),
                                              child: Center(
                                                child: FittedBox(
                                                  child: Text(
                                                    OrderModelController
                                                        .assignedOrdersModel
                                                        .data[index]
                                                        .deliveryStatus,
                                                    style: GoogleFonts.openSans(
                                                      fontSize: 12.0.sp,
                                                      color: OrderModelController
                                                                  .assignedOrdersModel
                                                                  .data[index]
                                                                  .deliveryStatus
                                                                  .toLowerCase() ==
                                                              'revisit'
                                                          ? AppColors
                                                              .dullPrimary
                                                          : OrderModelController
                                                                      .assignedOrdersModel
                                                                      .data[
                                                                          index]
                                                                      .deliveryStatus
                                                                      .toLowerCase() ==
                                                                  'cancel'
                                                              ? AppColors
                                                                  .brightRedColor
                                                              : OrderModelController
                                                                          .assignedOrdersModel
                                                                          .data[
                                                                              index]
                                                                          .deliveryStatus
                                                                          .toLowerCase() ==
                                                                      'on_hold'
                                                                  ? AppColors
                                                                      .orangeColor
                                                                  : OrderModelController
                                                                              .assignedOrdersModel
                                                                              .data[
                                                                                  index]
                                                                              .deliveryStatus
                                                                              .toLowerCase() ==
                                                                          'pending'
                                                                      ? AppColors
                                                                          .greyColor
                                                                      : AppColors
                                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.sp,
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: MySharedPrefs.getLocale()!
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                        child: Text(
                                          '${'Date'.tr()} : ${OrderModelController.assignedOrdersModel.data[index].orderDate}',
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
                                            child: Align(
                                                alignment:
                                                    MySharedPrefs.getLocale()!
                                                        ? Alignment.centerLeft
                                                        : Alignment.centerRight,
                                                child: CustomerShopWidget(
                                                  title: 'Customer Name'.tr(),
                                                  value: OrderModelController
                                                      .assignedOrdersModel
                                                      .data[index]
                                                      .customerName
                                                      .toString(),
                                                )),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  MySharedPrefs.getLocale()!
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                              child: CustomerShopWidget(
                                                title: 'Shop Name'.tr(),
                                                value: OrderModelController
                                                    .assignedOrdersModel
                                                    .data[index]
                                                    .address
                                                    .shopName
                                                    .toString(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp, vertical: 10.sp),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(3.0.r),
                                      ),
                                      color: const Color(0xFFF8F8F8),
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: MySharedPrefs.getLocale()!
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                          child: Text(
                                            'Drop Off'.tr(),
                                            style: GoogleFonts.cairo(
                                              fontSize: 14.0.sp,
                                              color: const Color(0xFF707070),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: MySharedPrefs.getLocale()!
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                          child: Text(
                                            OrderModelController
                                                .assignedOrdersModel
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
                                                        : Alignment.centerRight,
                                                    child: SvgPicture.asset(
                                                        Images.timer))),
                                            Expanded(
                                              flex: 10,
                                              child: Align(
                                                alignment:
                                                    MySharedPrefs.getLocale()!
                                                        ? Alignment.centerLeft
                                                        : Alignment.centerRight,
                                                child: Text(
                                                  '${OrderModelController.distance[index]} ${OrderModelController.kmDistance[index]}',
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 12.0.sp,
                                                    color:
                                                        const Color(0xFF707171),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        );
                      }),
                ],
              );
      },
    );
  }
}
