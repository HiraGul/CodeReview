import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/DeliveryStartedAnimationCubit/animation_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/pick_order_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/pick_order_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/customer_shop_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/empty_state.dart';

class PickedOrders extends StatefulWidget {
  final PageController controller;

  const PickedOrders({required this.controller, Key? key}) : super(key: key);

  @override
  State<PickedOrders> createState() => _PickedOrdersState();
}

class _PickedOrdersState extends State<PickedOrders> {
  @override
  void initState() {
    BlocProvider.of<AnimationCubit>(context).changeStatus(false);
    super.initState();
  }

  updatePriority(index) {
    final newIndex = index;

    OrderModelController.pickedOrdersModel.data[index].deliveryBoyPriority =
        newIndex + 1;
  }

  @override
  Widget build(BuildContext context) {
    return OrderModelController.pickedOrdersModel.data.isEmpty
        ? const EmptyData()
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 0.1.sh, top: 10.sp),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: OrderModelController.pickedOrdersModel.data.length,
            itemBuilder: (context, index) {
              updatePriority(index);
              PickOrderController.pickOrderList.add(PickOrderModel(
                  orderId: OrderModelController.pickedOrdersModel.data[index].id
                      .toString(),
                  priority: OrderModelController
                      .pickedOrdersModel.data[index].deliveryBoyPriority
                      .toString()));
              return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 17.sp, vertical: 10.sp),
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
                          Align(
                            alignment: MySharedPrefs.getLocale()!
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Text(
                              '${'Invoice ID:'.tr()} ${OrderModelController.pickedOrdersModel.data[index].id}',
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
                              '${'Invoice ID:'.tr()}: ${OrderModelController.pickedOrdersModel.data[index].orderDate}',
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
                                    alignment: MySharedPrefs.getLocale()!
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    child: CustomerShopWidget(
                                      title: 'Customer Name'.tr(),
                                      value: OrderModelController
                                          .pickedOrdersModel
                                          .data[index]
                                          .customerName
                                          .toString(),
                                    )),
                              ),
                              const Spacer(),
                              Expanded(
                                child: Align(
                                  alignment: MySharedPrefs.getLocale()!
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: CustomerShopWidget(
                                    title: 'Shop Name'.tr(),
                                    value: OrderModelController
                                        .pickedOrdersModel
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
                                OrderModelController.pickedOrdersModel
                                    .data[index].address.address
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
                                        alignment: MySharedPrefs.getLocale()!
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                        child: SvgPicture.asset(Images.timer))),
                                Expanded(
                                  flex: 10,
                                  child: Align(
                                    alignment: MySharedPrefs.getLocale()!
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    child: Text(
                                      '${OrderModelController.pickedDistance[index]} ${OrderModelController.pickedKmDistance[index]}',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12.0.sp,
                                        color: const Color(0xFF707171),
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
                  ));
            });
  }
}
