import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/allOrderCubit/all_order_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/allOrders/state_component.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/payLaterRequestView/components/row_cell_component.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/payLaterRequestView/components/title_row_cell_component.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_text.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/empty_state.dart';
import 'package:tojjar_delivery_app/commonWidgets/no_internet.dart';

import '../../../../DELIVERY/Utils/strings.dart';
import '../../../controller/cubits/allOrderCubit/all_order_cubit.dart';
import '../../../data/dataController/data_controller.dart';
import '../../widgets/custom_app_bar.dart';

class AllOrdersView extends StatefulWidget {
  const AllOrdersView({super.key});

  @override
  State<AllOrdersView> createState() => _AllOrdersViewState();
}

class _AllOrdersViewState extends State<AllOrdersView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AllOrderCubit>().fetchAllOrder();
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
        title: BlocBuilder<AllOrderCubit, AllOrderState>(
          builder: (context, state) {
            if (state is AllOrderLoadedState) {
              return MyText(
                text:
                    " ${'All Orders'.tr()} (${allOrderModelController!.orders!.length})",
                size: 18.sp,
                weight: FontWeight.bold,
                color: textDarkColor,
              );
            }
            return MyText(
              text: "${'All Orders'.tr()} (0)",
              size: 18.sp,
              weight: FontWeight.bold,
              color: textDarkColor,
            );
          },
        ),
        titleColor: textDarkColor,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 30.sp),
        children: [
          BlocBuilder<AllOrderCubit, AllOrderState>(
            builder: (context, state) {
              if (state is AllOrderLoadedState) {
                return Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FlexColumnWidth(70.sp),
                      1: FlexColumnWidth(100.sp),
                      2: FlexColumnWidth(100.sp),
                      3: FlexColumnWidth(100.sp),
                      4: FlexColumnWidth(80.sp)
                    },
                    border: TableBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.sp)),
                        top: BorderSide(color: loginBtnColor, width: 0.2.sp),
                        left: BorderSide(color: loginBtnColor, width: 0.2.sp),
                        right: BorderSide(color: loginBtnColor, width: 0.2.sp),
                        bottom:
                            BorderSide(color: loginBtnColor, width: 0.2.sp)),
                    children: List.generate(
                        allOrderModelController!.orders!.length + 1,
                        (index) => index == 0
                            ? TableRow(
                                decoration: const BoxDecoration(
                                  color: lightGray,
                                ),
                                children: [
                                    TitleRowCellComponent(
                                        text: 'Order Number'.tr(),
                                        height: 60.sp),
                                    TitleRowCellComponent(
                                        text: "Order Placed Date".tr(),
                                        height: 60.sp),
                                    TitleRowCellComponent(
                                        text:
                                            'Order Total(Inclusive Price)'.tr(),
                                        height: 60.sp),
                                    TitleRowCellComponent(
                                        text: 'Order Status'.tr(),
                                        height: 60.sp),
                                    TitleRowCellComponent(
                                        text: 'Details'.tr(), height: 60.sp),
                                  ])
                            : TableRow(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 0.5.sp,
                                            color: borderColor))),
                                children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                          left: 15.sp, top: 15.sp),
                                      height: 60.sp,
                                      child: MyText(
                                        text: allOrderModelController!
                                            .orders![index - 1].code
                                            .toString(),
                                        size: 10.sp,
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                    RowCellComponent(
                                        text: allOrderModelController!
                                            .orders![index - 1].placedDate
                                            .toString()),
                                    RowCellComponent(
                                        text:
                                            "${allOrderModelController!.orders![index - 1].total.toString()} (SAR)"),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          left: 15.sp, top: 10.sp),
                                      height: 60.sp,
                                      child: Container(
                                        height: 25.sp,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: allOrderModelController!
                                                        .orders![index - 1]
                                                        .status ==
                                                    'cancelled'
                                                ? returnedColor
                                                : allOrderModelController!
                                                            .orders![index - 1]
                                                            .status ==
                                                        'pending'
                                                    ? inProcessColor
                                                    : allOrderModelController!
                                                                .orders![
                                                                    index - 1]
                                                                .status ==
                                                            'picked_up'
                                                        ? pickedUpColor
                                                        : allOrderModelController!
                                                                    .orders![
                                                                        index -
                                                                            1]
                                                                    .status ==
                                                                'revisit'
                                                            ? revisitColor
                                                            : deliveredColor),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: MyText(
                                            text: allOrderModelController!
                                                .orders![index - 1].status
                                                .toString(),
                                            size: 13.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 60.sp,
                                      padding: EdgeInsets.only(
                                          left: 15.sp, top: 6.sp),
                                      child: IconButton(
                                          alignment: Alignment.center,
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, Strings.orderDetail,
                                                arguments:
                                                    allOrderModelController!
                                                        .orders![index - 1].id);
                                          },
                                          icon: Icon(
                                            Icons.visibility_outlined,
                                            color: loginBtnColor,
                                            size: 20.sp,
                                          )),
                                    )
                                  ])));
              }
              if (state is AllOrderLoadingState) {
                return Center(
                  child: loadingIndicator(),
                );
              }
              if (state is AllOrderNoDataState) {
                return const StateComponent(state: EmptyData());
              }
              if (state is AllOrderNoInternetState) {
                return StateComponent(state: NoInternetWidget(onTap: () {
                  context.read<AllOrderCubit>().fetchAllOrder();
                }));
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
