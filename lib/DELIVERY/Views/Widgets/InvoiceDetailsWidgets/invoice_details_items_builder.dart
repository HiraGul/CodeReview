import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/check_box_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/sub_total.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/tax_amount.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/ItemsEditCubit/items_edit_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/checkBox_widget.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/icon_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/FlutterToast.dart';

import '../../../Controllers/Cubits/InvoiceSummaryCubits/price.dart';

/// This File needs to be removed from the system
class ItemBuilder extends StatefulWidget {
  const ItemBuilder({
    Key? key,
    required,
  }) : super(key: key);

  @override
  State<ItemBuilder> createState() => _ItemBuilderState();
}

class _ItemBuilderState extends State<ItemBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: ListView.separated(
        primary: false,

        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
        itemCount:
            OrderDetailsController.orderDetailModel.data.orderDetails!.length,

        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                CheckBoxWidget(
                  itemIndex: index,
                  myEnum: CheckBoxEnum.orderDetail,
                ),

                SizedBox(
                  width: 20.sp,
                ),

                /// Name of the quantity
                ///
                const Spacer(
                  flex: 2,
                ),

                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: MySharedPrefs.getLocale()!
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      OrderDetailsController.orderDetailModel.data
                          .orderDetails![index].product!.name
                          .toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 14.0.sp,
                        color: const Color(0xFF292929),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.sp,
                ),

                Expanded(child: BlocBuilder<PriceCubit, double>(
                  builder: (context, totalPrice) {
                    return BlocBuilder<SubTotalCubit, double>(
                      builder: (context, totalSubtotal) {
                        return BlocBuilder<TaxAmountCubit, double>(
                          builder: (context, totalTax) {
                            return BlocBuilder<ItemsEdit, List<int>>(
                              builder: (context, state) {
                                return BlocBuilder<SelectSingleProductCubit,
                                    List<bool>>(
                                  builder: (context, singleCheck) {
                                    return GestureDetector(
                                      onTap: () async {
                                        if (singleCheck[index]) {
                                          if (state[index] > 1) {
                                            var indexOfId =
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .productId;
                                            print(OrderDetailsController
                                                .deliveredOrderList.length);

                                            print(
                                                '========= index of id $indexOfId');
                                            var indexOfDelivered = 0;

                                            OrderDetailsController
                                                .deliveredOrderList
                                                .forEach((element) {
                                              print(
                                                  '===========product id  ${element.productId}');
                                              print(
                                                  '===========index of id ${indexOfId}');
                                              if (element.productId ==
                                                  indexOfId) {
                                                OrderDetailsController
                                                    .deliveredOrderList[
                                                        indexOfDelivered]
                                                    .quantity = --state[index];
                                                indexOfDelivered =
                                                    OrderDetailsController
                                                        .deliveredOrderList
                                                        .indexOf(element);
                                              }
                                            });

                                            /// TO BE REMOVED
                                            OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .quantity =
                                                OrderDetailsController
                                                    .deliveredOrderList[
                                                        indexOfDelivered]
                                                    .quantity;
                                            double subTotal = double.parse(
                                                    OrderDetailsController
                                                        .orderDetailModel
                                                        .data
                                                        .subTotal!
                                                        .replaceAll(",", "")) -
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityPrice!
                                                    .toDouble();

                                            OrderDetailsController
                                                .orderDetailModel
                                                .data
                                                .subTotal = subTotal.toString();
                                            double tax = double.parse(
                                                    OrderDetailsController
                                                        .orderDetailModel
                                                        .data
                                                        .tax!) -
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityTax!
                                                    .toDouble();

                                            OrderDetailsController
                                                .orderDetailModel
                                                .data
                                                .tax = tax.toString();

                                            OrderDetailsController
                                                .orderDetailModel
                                                .data
                                                .grandTotal = double.parse(
                                                    OrderDetailsController
                                                        .orderDetailModel
                                                        .data
                                                        .subTotal
                                                        .toString()
                                                        .replaceAll(",", "")) +
                                                double.parse(
                                                    OrderDetailsController
                                                        .orderDetailModel
                                                        .data
                                                        .tax
                                                        .toString());
                                            debugPrint(
                                                "SUB PRICE ${OrderDetailsController.orderDetailModel.data.subTotal}");
                                            debugPrint(
                                                "TAX ${OrderDetailsController.orderDetailModel.data.tax}");

                                            /// END
                                            BlocProvider.of<ItemsEdit>(context)
                                                .changedItemValue(
                                              items: state,
                                            );

                                            OrderDetailsController
                                                .orderDetailModel
                                                .data
                                                .orderDetails![index]
                                                .price = OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .price -
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityPrice;

                                            OrderDetailsController
                                                .orderDetailModel
                                                .data
                                                .orderDetails![index]
                                                .tax = OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .tax -
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityTax;

                                            var perQuantityTax =
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityTax!;

                                            var perQuantityPrice =
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityPrice!;

                                            var perGrandTotal = perQuantityTax +
                                                perQuantityPrice;

                                            final newTax =
                                                totalTax - perQuantityTax;
                                            final newPrice = totalSubtotal -
                                                perQuantityPrice;
                                            final newGrandTotal =
                                                totalPrice - perGrandTotal;

                                            BlocProvider.of<TaxAmountCubit>(
                                                    context)
                                                .setNewTaxTotal(newTax: newTax);
                                            BlocProvider.of<SubTotalCubit>(
                                                    context)
                                                .setNewSubTotal(
                                                    newSubTotal: newPrice);
                                            BlocProvider.of<PriceCubit>(context)
                                                .setNewPrice(
                                                    newPrice: newGrandTotal);

                                            setState(() {});
                                          } else {
                                            flutterSnackBar(
                                                context,
                                                'You have reached the minimum quantity limit'
                                                    .tr());
                                          }
                                        }
                                      },
                                      child: const IconsWidget(
                                        iconData: Icons.remove,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                )),

                /// Quantity of the item
                Expanded(
                  child: BlocBuilder<ItemsEdit, List<int>>(
                    builder: (context, list) {
                      return Container(
                        width: 22..sp,
                        height: 25.sp,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0.sp,
                            color: AppColors.bolGreyColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            list[index].toString(),
                            style: GoogleFonts.openSans(
                              fontSize: 12.0.sp,
                              color: AppColors.greyColor,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(child: BlocBuilder<PriceCubit, double>(
                  builder: (context, totalPrice) {
                    return BlocBuilder<SubTotalCubit, double>(
                      builder: (context, totalSubtotal) {
                        return BlocBuilder<TaxAmountCubit, double>(
                          builder: (context, totalTax) {
                            return BlocBuilder<ItemsEdit, List<int>>(
                              builder: (context, state) {
                                return BlocBuilder<SelectSingleProductCubit,
                                    List<bool>>(
                                  builder: (context, singleCheck) {
                                    return GestureDetector(
                                      onTap: () async {
                                        if (singleCheck[index] == true) {
                                          if (state[index] <
                                              OrderDetailsController
                                                  .orderDetailModel
                                                  .data
                                                  .orderDetails![index]
                                                  .maxQuantity!) {
                                            var indexOfId =
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .productId;
                                            print(OrderDetailsController
                                                .deliveredOrderList.length);

                                            print(
                                                '========= index of id $indexOfId');
                                            var indexOfDelivered = 0;

                                            OrderDetailsController
                                                .deliveredOrderList
                                                .forEach((element) {
                                              print(
                                                  '===========product id  ${element.productId}');
                                              print(
                                                  '===========index of id ${indexOfId}');
                                              if (element.productId ==
                                                  indexOfId) {
                                                OrderDetailsController
                                                    .deliveredOrderList[
                                                        indexOfDelivered]
                                                    .quantity = ++state[index];
                                                indexOfDelivered =
                                                    OrderDetailsController
                                                        .deliveredOrderList
                                                        .indexOf(element);
                                              }
                                            });
                                            // OrderDetailsController
                                            //     .deliveredOrderList[index]
                                            //     .quantity = ++state[index];

                                            /// TO BE REMOVED
                                            OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .quantity =
                                                OrderDetailsController
                                                    .deliveredOrderList[indexOfDelivered]
                                                    .quantity;
                                            double subTotal = double.parse(
                                                    OrderDetailsController
                                                        .orderDetailModel
                                                        .data
                                                        .subTotal!
                                                        .replaceAll(",", "")) +
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityPrice!
                                                    .toDouble();

                                            OrderDetailsController
                                                .orderDetailModel
                                                .data
                                                .subTotal = subTotal.toString();
                                            double tax = double.parse(
                                                    OrderDetailsController
                                                        .orderDetailModel
                                                        .data
                                                        .tax!) +
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityTax!
                                                    .toDouble();

                                            OrderDetailsController
                                                .orderDetailModel
                                                .data
                                                .tax = tax.toString();
                                            OrderDetailsController
                                                .orderDetailModel
                                                .data
                                                .grandTotal = double.parse(
                                                    OrderDetailsController
                                                        .orderDetailModel
                                                        .data
                                                        .subTotal
                                                        .toString()
                                                        .replaceAll(",", "")) +
                                                double.parse(
                                                    OrderDetailsController
                                                        .orderDetailModel
                                                        .data
                                                        .tax
                                                        .toString());

                                            debugPrint(
                                                "SUB PRICE ${OrderDetailsController.orderDetailModel.data.subTotal}");
                                            debugPrint(
                                                "TAX ${OrderDetailsController.orderDetailModel.data.tax}");

                                            /// END
                                            BlocProvider.of<ItemsEdit>(context)
                                                .changedItemValue(
                                              items: state,
                                            );
                                            OrderDetailsController
                                                .orderDetailModel
                                                .data
                                                .orderDetails![index]
                                                .price = OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .price +
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityPrice;

                                            OrderDetailsController
                                                .orderDetailModel
                                                .data
                                                .orderDetails![index]
                                                .tax = OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .tax +
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityTax;

                                            var perQuantityTax =
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityTax!;

                                            var perQuantityPrice =
                                                OrderDetailsController
                                                    .orderDetailModel
                                                    .data
                                                    .orderDetails![index]
                                                    .perQuantityPrice!;

                                            var perGrandTotal = perQuantityTax +
                                                perQuantityPrice;

                                            final newTax =
                                                totalTax + perQuantityTax;
                                            final newPrice = totalSubtotal +
                                                perQuantityPrice;
                                            final newGrandTotal =
                                                totalPrice + perGrandTotal;

                                            BlocProvider.of<TaxAmountCubit>(
                                                    context)
                                                .setNewTaxTotal(newTax: newTax);
                                            BlocProvider.of<SubTotalCubit>(
                                                    context)
                                                .setNewSubTotal(
                                                    newSubTotal: newPrice);
                                            BlocProvider.of<PriceCubit>(context)
                                                .setNewPrice(
                                                    newPrice: newGrandTotal);
                                            setState(() {});
                                          } else {
                                            flutterSnackBar(
                                                context,
                                                'Sorry we cannot add more items'
                                                    .tr());
                                          }
                                        }
                                      },
                                      child: const IconsWidget(
                                        iconData: Icons.add,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                )),
              ],
            ),
          );
        },

        /// this separatorBuilder is the line between the
        /// items
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
          );
        },
      ),
    );
  }
}

//return Container(
//       color: AppColors.whiteColor,
//       child: ListView.separated(
//         primary: false,
//
//         physics: const NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
//         itemCount:
//             OrderDetailsController.orderDetailModel.data.orderDetails!.length,
//
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               children: [
//                 CheckBoxWidget(
//                   itemIndex: index,
//                   myEnum: CheckBoxEnum.orderDetail,
//                 ),
//
//                 SizedBox(
//                   width: 20.sp,
//                 ),
//
//                 /// Name of the quantity
//                 ///
//                 const Spacer(
//                   flex: 2,
//                 ),
//
//                 Expanded(
//                   flex: 5,
//                   child: Align(
//                     alignment: MySharedPrefs.getLocale()!
//                         ? Alignment.centerLeft
//                         : Alignment.centerRight,
//                     child: Text(
//                       OrderDetailsController.orderDetailModel.data
//                           .orderDetails![index].product!.name
//                           .toString(),
//                       style: GoogleFonts.roboto(
//                         fontSize: 14.0.sp,
//                         color: const Color(0xFF292929),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 20.sp,
//                 ),
//
//                 Expanded(child: BlocBuilder<PriceCubit, double>(
//                   builder: (context, totalPrice) {
//                     return BlocBuilder<SubTotalCubit, double>(
//                       builder: (context, totalSubtotal) {
//                         return BlocBuilder<TaxAmountCubit, double>(
//                           builder: (context, totalTax) {
//                             return BlocBuilder<ItemsEdit, List<int>>(
//                               builder: (context, state) {
//                                 return BlocBuilder<SelectSingleProductCubit,
//                                     List<bool>>(
//                                   builder: (context, singleCheck) {
//                                     return GestureDetector(
//                                       onTap: () async {
//                                         if (singleCheck[index]) {
//                                           if (state[index] > 1) {
//                                             print('======= index ${index}');
//                                             print(OrderDetailsController
//                                                 .deliveredOrderList.length);
//                                             OrderDetailsController
//                                                 .deliveredOrderList[index]
//                                                 .quantity = --state[index];
//
//                                             /// TO BE REMOVED
//                                             OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .quantity =
//                                                 OrderDetailsController
//                                                     .deliveredOrderList[index]
//                                                     .quantity;
//                                             double subTotal = double.parse(
//                                                     OrderDetailsController
//                                                         .orderDetailModel
//                                                         .data
//                                                         .subTotal!
//                                                         .replaceAll(",", "")) -
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityPrice!
//                                                     .toDouble();
//
//                                             OrderDetailsController
//                                                 .orderDetailModel
//                                                 .data
//                                                 .subTotal = subTotal.toString();
//                                             double tax = double.parse(
//                                                     OrderDetailsController
//                                                         .orderDetailModel
//                                                         .data
//                                                         .tax!) -
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityTax!
//                                                     .toDouble();
//
//                                             OrderDetailsController
//                                                 .orderDetailModel
//                                                 .data
//                                                 .tax = tax.toString();
//
//                                             OrderDetailsController
//                                                 .orderDetailModel
//                                                 .data
//                                                 .grandTotal = double.parse(
//                                                     OrderDetailsController
//                                                         .orderDetailModel
//                                                         .data
//                                                         .subTotal
//                                                         .toString()
//                                                         .replaceAll(",", "")) +
//                                                 double.parse(
//                                                     OrderDetailsController
//                                                         .orderDetailModel
//                                                         .data
//                                                         .tax
//                                                         .toString());
//                                             debugPrint(
//                                                 "SUB PRICE ${OrderDetailsController.orderDetailModel.data.subTotal}");
//                                             debugPrint(
//                                                 "TAX ${OrderDetailsController.orderDetailModel.data.tax}");
//
//                                             /// END
//                                             BlocProvider.of<ItemsEdit>(context)
//                                                 .changedItemValue(
//                                               items: state,
//                                             );
//
//                                             OrderDetailsController
//                                                 .orderDetailModel
//                                                 .data
//                                                 .orderDetails![index]
//                                                 .price = OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .price -
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityPrice;
//
//                                             OrderDetailsController
//                                                 .orderDetailModel
//                                                 .data
//                                                 .orderDetails![index]
//                                                 .tax = OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .tax -
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityTax;
//
//                                             var perQuantityTax =
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityTax!;
//
//                                             var perQuantityPrice =
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityPrice!;
//
//                                             var perGrandTotal = perQuantityTax +
//                                                 perQuantityPrice;
//
//                                             final newTax =
//                                                 totalTax - perQuantityTax;
//                                             final newPrice = totalSubtotal -
//                                                 perQuantityPrice;
//                                             final newGrandTotal =
//                                                 totalPrice - perGrandTotal;
//
//                                             BlocProvider.of<TaxAmountCubit>(
//                                                     context)
//                                                 .setNewTaxTotal(newTax: newTax);
//                                             BlocProvider.of<SubTotalCubit>(
//                                                     context)
//                                                 .setNewSubTotal(
//                                                     newSubTotal: newPrice);
//                                             BlocProvider.of<PriceCubit>(context)
//                                                 .setNewPrice(
//                                                     newPrice: newGrandTotal);
//
//                                             setState(() {});
//                                           } else {
//                                             flutterSnackBar(
//                                                 context,
//                                                 'You have reached the minimum quantity limit'
//                                                     .tr());
//                                           }
//                                         }
//                                       },
//                                       child: const IconsWidget(
//                                         iconData: Icons.remove,
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 )),
//
//                 /// Quantity of the item
//                 Expanded(
//                   child: BlocBuilder<ItemsEdit, List<int>>(
//                     builder: (context, list) {
//                       return Container(
//                         width: 22..sp,
//                         height: 25.sp,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             width: 1.0.sp,
//                             color: AppColors.bolGreyColor,
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             list[index].toString(),
//                             style: GoogleFonts.openSans(
//                               fontSize: 12.0.sp,
//                               color: AppColors.greyColor,
//                               fontWeight: FontWeight.w700,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Expanded(child: BlocBuilder<PriceCubit, double>(
//                   builder: (context, totalPrice) {
//                     return BlocBuilder<SubTotalCubit, double>(
//                       builder: (context, totalSubtotal) {
//                         return BlocBuilder<TaxAmountCubit, double>(
//                           builder: (context, totalTax) {
//                             return BlocBuilder<ItemsEdit, List<int>>(
//                               builder: (context, state) {
//                                 return BlocBuilder<SelectSingleProductCubit,
//                                     List<bool>>(
//                                   builder: (context, singleCheck) {
//                                     return GestureDetector(
//                                       onTap: () async {
//                                         if (singleCheck[index] == true) {
//                                           if (state[index] <
//                                               OrderDetailsController
//                                                   .orderDetailModel
//                                                   .data
//                                                   .orderDetails![index]
//                                                   .maxQuantity!) {
//                                             OrderDetailsController
//                                                 .deliveredOrderList[index]
//                                                 .quantity = ++state[index];
//
//                                             /// TO BE REMOVED
//                                             OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .quantity =
//                                                 OrderDetailsController
//                                                     .deliveredOrderList[index]
//                                                     .quantity;
//                                             double subTotal = double.parse(
//                                                     OrderDetailsController
//                                                         .orderDetailModel
//                                                         .data
//                                                         .subTotal!
//                                                         .replaceAll(",", "")) +
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityPrice!
//                                                     .toDouble();
//
//                                             OrderDetailsController
//                                                 .orderDetailModel
//                                                 .data
//                                                 .subTotal = subTotal.toString();
//                                             double tax = double.parse(
//                                                     OrderDetailsController
//                                                         .orderDetailModel
//                                                         .data
//                                                         .tax!) +
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityTax!
//                                                     .toDouble();
//
//                                             OrderDetailsController
//                                                 .orderDetailModel
//                                                 .data
//                                                 .tax = tax.toString();
//                                             OrderDetailsController
//                                                 .orderDetailModel
//                                                 .data
//                                                 .grandTotal = double.parse(
//                                                     OrderDetailsController
//                                                         .orderDetailModel
//                                                         .data
//                                                         .subTotal
//                                                         .toString()
//                                                         .replaceAll(",", "")) +
//                                                 double.parse(
//                                                     OrderDetailsController
//                                                         .orderDetailModel
//                                                         .data
//                                                         .tax
//                                                         .toString());
//
//                                             debugPrint(
//                                                 "SUB PRICE ${OrderDetailsController.orderDetailModel.data.subTotal}");
//                                             debugPrint(
//                                                 "TAX ${OrderDetailsController.orderDetailModel.data.tax}");
//
//                                             /// END
//                                             BlocProvider.of<ItemsEdit>(context)
//                                                 .changedItemValue(
//                                               items: state,
//                                             );
//                                             OrderDetailsController
//                                                 .orderDetailModel
//                                                 .data
//                                                 .orderDetails![index]
//                                                 .price = OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .price +
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityPrice;
//
//                                             OrderDetailsController
//                                                 .orderDetailModel
//                                                 .data
//                                                 .orderDetails![index]
//                                                 .tax = OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .tax +
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityTax;
//
//                                             var perQuantityTax =
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityTax!;
//
//                                             var perQuantityPrice =
//                                                 OrderDetailsController
//                                                     .orderDetailModel
//                                                     .data
//                                                     .orderDetails![index]
//                                                     .perQuantityPrice!;
//
//                                             var perGrandTotal = perQuantityTax +
//                                                 perQuantityPrice;
//
//                                             final newTax =
//                                                 totalTax + perQuantityTax;
//                                             final newPrice = totalSubtotal +
//                                                 perQuantityPrice;
//                                             final newGrandTotal =
//                                                 totalPrice + perGrandTotal;
//
//                                             BlocProvider.of<TaxAmountCubit>(
//                                                     context)
//                                                 .setNewTaxTotal(newTax: newTax);
//                                             BlocProvider.of<SubTotalCubit>(
//                                                     context)
//                                                 .setNewSubTotal(
//                                                     newSubTotal: newPrice);
//                                             BlocProvider.of<PriceCubit>(context)
//                                                 .setNewPrice(
//                                                     newPrice: newGrandTotal);
//                                             setState(() {});
//                                           } else {
//                                             flutterSnackBar(
//                                                 context,
//                                                 'Sorry we cannot add more items'
//                                                     .tr());
//                                           }
//                                         }
//                                       },
//                                       child: const IconsWidget(
//                                         iconData: Icons.add,
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 )),
//               ],
//             ),
//           );
//         },
//
//         /// this separatorBuilder is the line between the
//         /// items
//         separatorBuilder: (context, index) {
//           return const Divider(
//             thickness: 1,
//           );
//         },
//       ),
//     );
