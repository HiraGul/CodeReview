import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/DriverOrderDetailsCubit/order_details_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/check_box_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/price.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/sub_total.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/tax_amount.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/ItemsEditCubit/items_edit_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/delivered_cubit/select_all_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/partial_payment_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/pay_later_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SignatureScreen/signature_partial_pay.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SignatureScreen/signature_pay_later.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AppBar/appbar.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/DeliveryDetailsWidget/item_builder_order_detail.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/DeliveryDetailsWidget/make_call_widget.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/customer_shop_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/error_widget.dart';

import '../../../../commonWidgets/no_internet.dart';
import '../../Widgets/DeliveryDetailsWidget/bottom_nav_button.dart';

class DeliveryDetailScreen extends StatefulWidget {
  const DeliveryDetailScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  @override
  void initState() {
    OrderDetailsController.deliveredOrderList.clear();
    OrderDetailsController.items.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      bottomNavigationBar: ReachedButtonWidget(
        buttonColor: AppColors.primaryColor,
        title: "Reached".tr(),
        onTap: () {
          print("Statuses");
          print(PayLaterRepo.payLetterStatus);
          print(PartialPaymentRepo.partialStatus);

          if (PayLaterRepo.payLetterStatus != 'null' &&
              PayLaterRepo.payLetterStatus != -1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ESignaturePayLaterScreen(
                          orderId: OrderDetailsController
                              .orderDetailModel.data.id
                              .toString(),
                          isTerminatedState: true,
                        )));
          } else if (PartialPaymentRepo.partialStatus != 'null' &&
              PartialPaymentRepo.partialStatus != -1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignaturePartialPay(
                          orderId: OrderDetailsController
                              .orderDetailModel.data.id
                              .toString(),
                          isTerminatedState: true,
                        )));
          } else {
            Navigator.pushNamed(context, Strings.invoiceDetailsScreen);
          }
        },
      ),
      body: SafeArea(
        child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
            if (state is OrderDetailsLoading) {
              return Center(child: loadingIndicator());
            }
            if (state is OrderDetailsException) {
              return CustomErrorStateIndicator(
                onTap: () {
                  BlocProvider.of<OrderDetailsCubit>(context)
                      .getOrderDetailsCubit(
                          orderId: OrderDetailsController
                              .orderDetailModel.data.id
                              .toString());
                },
              );
            }
            if (state is OrderDetailsSocketException) {
              return NoInternetWidget(
                onTap: () {
                  BlocProvider.of<OrderDetailsCubit>(context)
                      .getOrderDetailsCubit(
                          orderId: OrderDetailsController
                              .orderDetailModel.data.id
                              .toString());
                },
              );
            }
            if (state is OrderDetailsLoaded) {
              final List<bool> newList = [];
              final List<int> quantityList = [];
              BlocProvider.of<TaxAmountCubit>(context).setNewTaxTotal(
                  newTax: double.parse(
                      OrderDetailsController.orderDetailModel.data.tax!));
              BlocProvider.of<SubTotalCubit>(context).setNewSubTotal(
                  newSubTotal: double.parse(OrderDetailsController
                      .orderDetailModel.data.subTotal!
                      .toString()
                      .replaceAll(",", "")));
              BlocProvider.of<PriceCubit>(context).setNewPrice(
                  newPrice:
                      OrderDetailsController.orderDetailModel.data.grandTotal!);

              /// unselect all items
              context.read<SelectAllCubit>().getSelectAll(value: false);

              /// assign initial quantity
              for (int i = 0;
                  i <
                      OrderDetailsController
                          .orderDetailModel.data.orderDetails!.length;
                  i++) {
                newList.add(false);
                quantityList.add(OrderDetailsController
                    .orderDetailModel.data.orderDetails![i].quantity!);
              }

              /// unselect single items initially
              BlocProvider.of<ItemsEdit>(context)
                  .changedItemValue(items: quantityList);
              context
                  .read<SelectSingleProductCubit>()
                  .getSelectAll(value: newList);

              /// Initially invoice will be zero
              BlocProvider.of<TaxAmountCubit>(context)
                  .setNewTaxTotal(newTax: 0.0);
              BlocProvider.of<SubTotalCubit>(context)
                  .setNewSubTotal(newSubTotal: 0.0);
              BlocProvider.of<PriceCubit>(context).setNewPrice(newPrice: 0.0);

              return ListView(
                physics: const BouncingScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 17.sp, vertical: 17.sp),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: buildAppBar(
                        title: "Back to Picked Orders".tr(),
                        context: context,
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: 382.0.sp,
                    decoration: const BoxDecoration(
                      color: Color(0xFFECF7FF),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE1E1E1),
                          offset: Offset(0, -0.5),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 17.sp),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 17.sp),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${"Invoice ID:".tr()}  ${OrderDetailsController.orderDetailModel.data.id} ',
                                  style: GoogleFonts.openSans(
                                    fontSize: 16.0,
                                    color: const Color(0xFF001E33),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: MakeCallWidget(
                                      phoneNumber: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .shippingAddress!
                                          .phone
                                          .toString())),
                            ],
                          ),
                        ),
                        Align(
                          alignment: MySharedPrefs.getLocale()!
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17.sp),
                            child: Text(
                              '${"Date :".tr()}${OrderDetailsController.orderDetailModel.data.date!}',
                              style: GoogleFonts.poppins(
                                fontSize: 11.0.sp,
                                color: const Color(0xFF444444),
                                fontWeight: FontWeight.w300,
                                height: 2.73,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 17.sp),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                    child: CustomerShopWidget(
                                  title: "Customer Name".tr(),
                                  value: OrderDetailsController.orderDetailModel
                                      .data.shippingAddress!.name
                                      .toString(),
                                )),
                              ),
                              const Spacer(),
                              Expanded(
                                child: CustomerShopWidget(
                                  title: "Shop Name".tr(),
                                  value: OrderDetailsController.orderDetailModel
                                      .data.shippingAddress!.shopName
                                      .toString(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.sp, vertical: 20.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(3.0.sp),
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
                                  "Shop Address".tr(),
                                  style: GoogleFonts.openSans(
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
                                  OrderDetailsController.orderDetailModel.data
                                      .shippingAddress!.address
                                      .toString(),
                                  style: GoogleFonts.openSans(
                                    fontSize: 16.0.sp,
                                    color: AppColors.blackColor,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                    width: 382.0.sp,
                    height: 48.0.sp,
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    color: const Color(0xFFF6F6F6),
                    child: Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: MySharedPrefs.getLocale()!
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Text(
                            '${"Item".tr()} ${OrderDetailsController.orderDetailModel.data.orderDetails!.length}',
                            style: GoogleFonts.roboto(
                              fontSize: 12.0,
                              color: const Color(0xFF474747),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Align(
                          alignment: MySharedPrefs.getLocale()!
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Text(
                            "Qty".tr(),
                            style: GoogleFonts.roboto(
                              fontSize: 12.0,
                              color: const Color(0xFF474747),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),

                  ///Item builder of specific order
                  const OrderDetailsItemBuilder()
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
