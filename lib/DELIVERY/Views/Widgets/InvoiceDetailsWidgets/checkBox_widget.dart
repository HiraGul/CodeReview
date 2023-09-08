import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/check_box_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/deliveries_length.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/price.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/sub_total.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/tax_amount.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/delivered_cubit/select_all_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/order_detail_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

enum CheckBoxEnum { orderDetail, orderDetailSelectAll }

class CheckBoxWidget extends StatefulWidget {
  final CheckBoxEnum? myEnum;

  final int? itemIndex;

  const CheckBoxWidget({
    Key? key,
    this.myEnum,
    this.itemIndex,
  }) : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  void initState() {
    super.initState();
    context.read<SelectAllCubit>().getSelectAll(value: true);
    context.read<SelectSingleProductCubit>().getSelectAll(
        value: List.generate(
            OrderDetailsController.orderDetailModel.data.orderDetails!.length,
            (index) => true));
    feedInvoiceData();
  }

  feedInvoiceData() async {
    for (int i = 0;
        i < OrderDetailsController.orderDetailModel.data.orderDetails!.length;
        i++) {
      // newBoolList.add(true);
      OrderDetailsController.deliveredOrderList.add(
        OrderDetails(
          productId: OrderDetailsController
              .orderDetailModel.data.orderDetails![i].productId,
          price: OrderDetailsController
              .orderDetailModel.data.orderDetails![i].price,
          quantity: OrderDetailsController
              .orderDetailModel.data.orderDetails![i].quantity,
          perQuantityPrice: OrderDetailsController
              .orderDetailModel.data.orderDetails![i].perQuantityPrice,
          orderId: OrderDetailsController
              .orderDetailModel.data.orderDetails![i].orderId,
          product: Product(
              id: OrderDetailsController
                  .orderDetailModel.data.orderDetails![i].product!.id,
              name: OrderDetailsController
                  .orderDetailModel.data.orderDetails![i].product!.name),
          tax:
              OrderDetailsController.orderDetailModel.data.orderDetails![i].tax,
          perQuantityTax: OrderDetailsController
              .orderDetailModel.data.orderDetails![i].perQuantityTax,
          maxQuantity: OrderDetailsController
              .orderDetailModel.data.orderDetails![i].maxQuantity,
        ),
      );
      print(
          "Total PRICE ${OrderDetailsController.orderDetailModel.data.orderDetails![i].price}");
      print(
          "Per PRICE ${OrderDetailsController.orderDetailModel.data.orderDetails![i].perQuantityPrice}");

      print(
          "QUANTITY ${OrderDetailsController.orderDetailModel.data.orderDetails![i].quantity}");
      print(
          "MAX QUANTITY ${OrderDetailsController.orderDetailModel.data.orderDetails![i].maxQuantity}");
    }

    // context
    //     .read<SelectSingleProductCubit>()
    //     .getSelectAll(value: newBoolList);

    BlocProvider.of<TaxAmountCubit>(context).setNewTaxTotal(
        newTax:
            double.parse(OrderDetailsController.orderDetailModel.data.tax!));
    BlocProvider.of<SubTotalCubit>(context).setNewSubTotal(
        newSubTotal: double.parse(OrderDetailsController
            .orderDetailModel.data.subTotal!
            .replaceAll(",", "")));
    BlocProvider.of<PriceCubit>(context).setNewPrice(
        newPrice: OrderDetailsController.orderDetailModel.data.grandTotal!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceCubit, double>(
      builder: (context, price) {
        return BlocBuilder<SubTotalCubit, double>(
          builder: (context, subTotal) {
            return BlocBuilder<TaxAmountCubit, double>(
              builder: (context, tax) {
                return BlocBuilder<SelectSingleProductCubit, List<bool>>(
                  builder: (context, singleProduct) {
                    return BlocBuilder<SelectAllCubit, bool>(
                      builder: (context, isSelectedAll) {
                        return GestureDetector(
                          onTap: () async {
                            List<bool> newBoolList = [];

                            if (widget.myEnum ==
                                CheckBoxEnum.orderDetailSelectAll) {
                              setState(() {
                                isSelectedAll = !isSelectedAll;
                              });
                            } else {
                              setState(() {
                                singleProduct[widget.itemIndex!] =
                                    !singleProduct[widget.itemIndex!];
                              });
                            }

                            if (widget.myEnum ==
                                CheckBoxEnum.orderDetailSelectAll) {
                              context
                                  .read<SelectAllCubit>()
                                  .getSelectAll(value: isSelectedAll);

                              if (isSelectedAll) {
                                OrderDetailsController.deliveredOrderList = [];

                                for (int i = 0;
                                    i <
                                        OrderDetailsController.orderDetailModel
                                            .data.orderDetails!.length;
                                    i++) {
                                  newBoolList.add(true);
                                  OrderDetailsController.deliveredOrderList.add(
                                    OrderDetails(
                                      productId: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![i]
                                          .productId,
                                      price: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![i]
                                          .price,
                                      quantity: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![i]
                                          .quantity,
                                      perQuantityPrice: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![i]
                                          .perQuantityPrice,
                                      orderId: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![i]
                                          .orderId,
                                      product: Product(
                                          id: OrderDetailsController
                                              .orderDetailModel
                                              .data
                                              .orderDetails![i]
                                              .product!
                                              .id,
                                          name: OrderDetailsController
                                              .orderDetailModel
                                              .data
                                              .orderDetails![i]
                                              .product!
                                              .name),
                                      tax: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![i]
                                          .tax,
                                      perQuantityTax: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![i]
                                          .perQuantityTax,
                                      maxQuantity: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![i]
                                          .maxQuantity,
                                    ),
                                  );
                                  print(
                                      "Total PRICE ${OrderDetailsController.orderDetailModel.data.orderDetails![i].price}");
                                  print(
                                      "Per PRICE ${OrderDetailsController.orderDetailModel.data.orderDetails![i].perQuantityPrice}");

                                  print(
                                      "QUANTITY ${OrderDetailsController.orderDetailModel.data.orderDetails![i].quantity}");
                                  print(
                                      "MAX QUANTITY ${OrderDetailsController.orderDetailModel.data.orderDetails![i].maxQuantity}");
                                }

                                context
                                    .read<SelectSingleProductCubit>()
                                    .getSelectAll(value: newBoolList);

                                BlocProvider.of<TaxAmountCubit>(context)
                                    .setNewTaxTotal(
                                        newTax: double.parse(
                                            OrderDetailsController
                                                .orderDetailModel.data.tax!));
                                BlocProvider.of<SubTotalCubit>(context)
                                    .setNewSubTotal(
                                        newSubTotal: double.parse(
                                            OrderDetailsController
                                                .orderDetailModel.data.subTotal!
                                                .replaceAll(",", "")));
                                BlocProvider.of<PriceCubit>(context)
                                    .setNewPrice(
                                        newPrice: OrderDetailsController
                                            .orderDetailModel.data.grandTotal!);
                              } else {
                                OrderDetailsController.deliveredOrderList = [];
                                for (int i = 0;
                                    i <
                                        OrderDetailsController.orderDetailModel
                                            .data.orderDetails!.length;
                                    i++) {
                                  newBoolList.add(false);
                                }
                                context
                                    .read<SelectSingleProductCubit>()
                                    .getSelectAll(value: newBoolList);
                                BlocProvider.of<TaxAmountCubit>(context)
                                    .setNewTaxTotal(newTax: 0.0);
                                BlocProvider.of<SubTotalCubit>(context)
                                    .setNewSubTotal(newSubTotal: 0.0);
                                BlocProvider.of<PriceCubit>(context)
                                    .setNewPrice(newPrice: 0.0);
                              }
                            } else {
                              context
                                  .read<SelectSingleProductCubit>()
                                  .getSelectAll(value: singleProduct);

                              if (widget.myEnum == CheckBoxEnum.orderDetail) {
                                final grandTotal = (OrderDetailsController
                                        .orderDetailModel
                                        .data
                                        .orderDetails![widget.itemIndex!]
                                        .price!) +
                                    (OrderDetailsController
                                        .orderDetailModel
                                        .data
                                        .orderDetails![widget.itemIndex!]
                                        .tax!);
                                if (singleProduct[widget.itemIndex!]) {
                                  OrderDetailsController.deliveredOrderList.add(
                                    OrderDetails(
                                      productId: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .productId,
                                      price: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .price,
                                      quantity: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .quantity,
                                      perQuantityPrice: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .perQuantityPrice,
                                      orderId: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .orderId,
                                      product: Product(
                                          id: OrderDetailsController
                                              .orderDetailModel
                                              .data
                                              .orderDetails![widget.itemIndex!]
                                              .product!
                                              .id,
                                          name: OrderDetailsController
                                              .orderDetailModel
                                              .data
                                              .orderDetails![widget.itemIndex!]
                                              .product!
                                              .name),
                                      tax: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .tax,
                                      perQuantityTax: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .perQuantityTax,
                                      maxQuantity: OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .maxQuantity,
                                    ),
                                  );

                                  final newTax = tax +
                                      OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .tax!;
                                  final newSubTotal = subTotal +
                                      OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .price!;
                                  final newPrice = price + grandTotal;

                                  BlocProvider.of<TaxAmountCubit>(context)
                                      .setNewTaxTotal(newTax: newTax);
                                  BlocProvider.of<SubTotalCubit>(context)
                                      .setNewSubTotal(newSubTotal: newSubTotal);
                                  BlocProvider.of<PriceCubit>(context)
                                      .setNewPrice(newPrice: newPrice);
                                } else {
                                  OrderDetailsController.deliveredOrderList
                                      .removeWhere((item) =>
                                          item.productId ==
                                          OrderDetailsController
                                              .orderDetailModel
                                              .data
                                              .orderDetails![widget.itemIndex!]
                                              .productId);

                                  context
                                      .read<SelectAllCubit>()
                                      .getSelectAll(value: false);
                                  final newTax = tax -
                                      OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .tax!;
                                  final newSubTotal = subTotal -
                                      OrderDetailsController
                                          .orderDetailModel
                                          .data
                                          .orderDetails![widget.itemIndex!]
                                          .price!;
                                  final newPrice = price - grandTotal;

                                  BlocProvider.of<TaxAmountCubit>(context)
                                      .setNewTaxTotal(newTax: newTax);
                                  BlocProvider.of<SubTotalCubit>(context)
                                      .setNewSubTotal(newSubTotal: newSubTotal);
                                  BlocProvider.of<PriceCubit>(context)
                                      .setNewPrice(newPrice: newPrice);
                                }
                              }
                            }

                            BlocProvider.of<DeliveriesLength>(context)
                                .deliveryLength(
                                    length: OrderDetailsController
                                        .deliveredOrderList.length);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 16.0.sp,
                            height: 16.0.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0.r),
                              color: Colors.white,
                              border: Border.all(
                                width: 1.0,
                                color: const Color(0xFFCED4DA),
                              ),
                            ),
                            child: Container(
                              width: 12.0.sp,
                              height: 12.0.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.0.r),
                                color: widget.myEnum ==
                                        CheckBoxEnum.orderDetailSelectAll
                                    ? isSelectedAll
                                        ? AppColors.primaryColor
                                        : AppColors.whiteColor
                                    : singleProduct[widget.itemIndex!]
                                        ? AppColors.primaryColor
                                        : AppColors.whiteColor,
                              ),
                            ),
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
    );
  }
}
