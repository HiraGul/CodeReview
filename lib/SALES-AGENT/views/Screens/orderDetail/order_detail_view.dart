import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/orderDetail/components/shop_detail_component.dart';

import '../../../../commonWidgets/LoadingWidget.dart';
import '../../../../commonWidgets/empty_state.dart';
import '../../../../commonWidgets/error_widget.dart';
import '../../../../commonWidgets/no_internet.dart';
import '../../../controller/cubits/orderDetailCubit/order_detail_cubit.dart';
import '../../../controller/cubits/orderDetailCubit/order_detail_state.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/expand_row_widget.dart';
import '../../widgets/info_detail_row.dart';
import '../../widgets/my_text.dart';
import 'components/customer_detail_component.dart';
import 'components/item_detail_table.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({super.key});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var id = ModalRoute.of(context)!.settings.arguments as int;

    context.read<OrderDetailCubit>().fetchOrderDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBar(
          onPressed: () {
            Navigator.pop(context);
          },
          leadingSize: 27.sp,
          parentContext: context,
          titleSize: 16.sp,
          titleWeight: FontWeight.w400,
          title: MyText(
            text: "Back To Orders".tr(),
            size: 16.sp,
            weight: FontWeight.w400,
            color: appBarTitleColor,
          ),
          titleColor: appBarTitleColor),
      body: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
            builder: (context, state) {
              if (state is OrderDetailLoadingState) {
                return Center(
                  child: loadingIndicator(),
                );
              }
              if (state is OrderDetailLoadedState) {
                return ListView(
                  padding: EdgeInsets.only(
                      left: 26.sp, top: 20.sp, bottom: 20.sp, right: 20.sp),
                  shrinkWrap: true,
                  children: [
                    const ComponentDetailComponent(),
                    8.ph,
                    const Divider(),
                    12.ph,
                    //shop detail component
                    const ShopDetailComponent(),
                    8.ph,
                    const Divider(),
                    10.ph,
                    Padding(
                      padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
                      child: Column(
                        children: [
                          Align(
                            alignment: context.locale.languageCode == 'en'
                                ? Alignment.topLeft
                                : Alignment.topRight,
                            child: MyText(
                              text: "Item Details".tr(),
                              size: 16.sp,
                              weight: FontWeight.bold,
                              color: textMediumColor,
                            ),
                          ),
                          15.ph,
                          //item detail table component
                          const ItemDetailTable(),
                          15.ph,
                          Container(
                            height: 38.sp,
                            padding: EdgeInsets.only(
                                left: 11.sp, top: 8.sp, bottom: 8.sp),
                            width: double.infinity,
                            decoration: const BoxDecoration(color: lightGray),
                            child: MyText(
                              text: 'Summary'.tr(),
                              size: 16.sp,
                              weight: FontWeight.bold,
                              color: textMediumColor,
                            ),
                          ),
                          10.ph,
                          ExpandRowWidget(
                            item1: 'Total Items'.tr(),
                            item1Color: labelColor,
                            item2: orderDetailModelController!
                                    .orders?.summary?.totalItems
                                    .toString() ??
                                '',
                            item2Color: Colors.black,
                          ),
                          8.ph,
                          ExpandRowWidget(
                            item1: 'Total Quantity'.tr(),
                            item1Color: labelColor,
                            item2: orderDetailModelController!
                                    .orders?.summary?.totalQty
                                    .toString() ??
                                '',
                            item2Color: Colors.black,
                          ),
                          4.ph,
                          const Divider(),
                          5.ph,
                          ExpandRowWidget(
                            item1: 'Total Amount'.tr(),
                            item1Color: Colors.black,
                            item2: orderDetailModelController!
                                    .orders?.summary?.totalAmount
                                    .toString() ??
                                '',
                            item2Size: 16.sp,
                            item2Color: yellowDark,
                            item1Weight: FontWeight.bold,
                            item2Weight: FontWeight.bold,
                          ),
                          // 10.ph,
                          // ExpandRowWidget(
                          //   item1: 'VAT'.tr(),
                          //   item1Color: Colors.black,
                          //   item2: "static",
                          //   item2Color: Colors.black,
                          //   item1Weight: FontWeight.bold,
                          // ),
                          // const Divider(),
                          // ExpandRowWidget(
                          //   item1: 'Net Amount'.tr(),
                          //   item1Color: Colors.black,
                          //   item2: 'static',
                          //   item2Size: 16.sp,
                          //   item2Color: yellowDark,
                          //   item1Weight: FontWeight.bold,
                          //   item2Weight: FontWeight.bold,
                          // ),
                          30.ph,
                          Align(
                            alignment: context.locale.languageCode == 'en'
                                ? Alignment.topLeft
                                : Alignment.topRight,
                            child: MyText(
                              text: "Shop Details".tr(),
                              size: 16.sp,
                              weight: FontWeight.bold,
                              color: loginBtnColor,
                            ),
                          ),
                          15.ph,
                          InfoDetailRow(
                              tag: "Order Date".tr(),
                              info: orderDetailModelController!
                                  .orders?.general?.orderDate),
                          12.ph,
                          InfoDetailRow(
                            tag: 'Payment Status'.tr(),
                            info: orderDetailModelController!
                                .orders?.general?.paymentStatus,
                            infoColor: greenColor,
                          ),
                          12.ph,
                          InfoDetailRow(
                            tag: 'Order Status'.tr(),
                            info: orderDetailModelController!
                                .orders?.general?.orderStatus,
                            infoColor: yellowDark,
                          ),
                          12.ph,
                          InfoDetailRow(
                              tag: 'Payment Method'.tr(),
                              info: orderDetailModelController!
                                  .orders?.general?.paymentMethod)
                        ],
                      ),
                    )
                  ],
                );
              }
              if (state is OrderDetailErrorState) {
                return CustomErrorStateIndicator(
                  onTap: () {},
                );
              }
              if (state is OrderDetailNoDataState) {
                return const EmptyData();
              }
              if (state is OrderDetailNoInternetState) {
                return NoInternetWidget(onTap: () {
                  var id = ModalRoute.of(context)!.settings.arguments as int;

                  context.read<OrderDetailCubit>().fetchOrderDetail(id);
                });
              }
              return const SizedBox();
            },
          )),
    );
  }
}
