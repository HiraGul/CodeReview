import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/agentDashboardCubit/agent_dashboard_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialHistoryRequestCubit/partial_history_request_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialHistoryRequestCubit/partial_history_request_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/payLaterRequestView/components/row_cell_component.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/payLaterRequestView/components/title_row_cell_component.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_rich_text.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_text.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/empty_state.dart';
import 'package:tojjar_delivery_app/commonWidgets/no_internet.dart';

class PartialHistoryRequestView extends StatefulWidget {
  const PartialHistoryRequestView({super.key});

  @override
  State<PartialHistoryRequestView> createState() =>
      _PartialHistoryRequestViewState();
}

class _PartialHistoryRequestViewState extends State<PartialHistoryRequestView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<RequestHistoryCubit>().fetchRequestHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 25.sp,
        backgroundColor: scaffoldColor,
        iconTheme: const IconThemeData(color: textDarkColor),
        title:
            BlocBuilder<PartialHistoryRequestCubit, PartialHistoryRequestState>(
          builder: (context, state) {
            return MyRichText(
              firstText: "Request History".tr(),
              secondText: partialRequestHistoryModelController != null
                  ? "${partialRequestHistoryModelController!.orders!.length}"
                  : "0",
              firstSize: 16.sp,
              secondSize: 18.sp,
              firstColor: textDarkColor,
              secondColor: loginBtnColor,
              firstWeight: FontWeight.w600,
              secondWeight: FontWeight.w600,
            );
          },
        ),
        leading: IconButton(
            onPressed: () {
              context.read<AgentDashboardCubit>().fetchAgentDashboard();

              Navigator.pushNamedAndRemoveUntil(
                  context, Strings.saleAgentDashboard, (route) => false);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 25.sp,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
        child: SingleChildScrollView(
          child: BlocBuilder<PartialHistoryRequestCubit,
              PartialHistoryRequestState>(
            builder: (context, state) {
              if (state is PartialHistoryRequestLoadedState) {
                return Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    // columnWidths: {
                    //   0: FlexColumnWidth(80.sp),
                    //   1: FlexColumnWidth(70.sp),
                    //   2: FlexColumnWidth(60.sp),
                    //   // 3: FlexColumnWidth(90.sp),
                    //   4: FlexColumnWidth(110.sp),
                    //   5: FlexColumnWidth(90.sp)
                    // },
                    border: TableBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.sp)),
                        top: BorderSide(color: loginBtnColor, width: 0.2.sp),
                        left: BorderSide(color: loginBtnColor, width: 0.2.sp),
                        right: BorderSide(color: loginBtnColor, width: 0.2.sp),
                        bottom:
                            BorderSide(color: loginBtnColor, width: 0.2.sp)),
                    children: List.generate(
                        partialRequestHistoryModelController!.orders!.length +
                            1,
                        (index) => index == 0
                            ? TableRow(
                                decoration: const BoxDecoration(
                                  color: lightGray,
                                ),
                                children: [
                                    TitleRowCellComponent(
                                      text: 'Driver Name'.tr(),
                                      height: 60.sp,
                                    ),
                                    TitleRowCellComponent(
                                      text: 'Shop Name'.tr(),
                                      height: 60.sp,
                                    ),
                                    TitleRowCellComponent(
                                      text: "Order Item".tr(),
                                      height: 60.sp,
                                    ),
                                    // TitleRowCellComponent(
                                    //   text: 'Amount to pay'.tr(),
                                    //   height: 60.sp,
                                    // ),
                                    TitleRowCellComponent(
                                      text: 'Request Date'.tr(),
                                      height: 60.sp,
                                    ),
                                    TitleRowCellComponent(
                                      text: 'Action'.tr(),
                                      height: 60.sp,
                                    ),
                                  ])
                            : TableRow(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 0.1.sp,
                                            color: Colors.grey))),
                                children: [
                                    RowCellComponent(
                                        text:
                                            "${partialRequestHistoryModelController?.orders?[index - 1].driverName}"),
                                    RowCellComponent(
                                        text:
                                            "${partialRequestHistoryModelController?.orders?[index - 1].shopName}"),
                                    RowCellComponent(
                                        text:
                                            "${partialRequestHistoryModelController?.orders?[index - 1].orderItems}"),
                                    // RowCellComponent(
                                    //     text:
                                    //         "${partialRequestHistoryModelController!.orders![index - 1].amountToPay}"),
                                    RowCellComponent(
                                        text:
                                            '${partialRequestHistoryModelController?.orders?[index - 1].requestDate}'),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          right: 5.sp,
                                          top: 10.sp,
                                          left: context.locale.languageCode ==
                                                  'en'
                                              ? 0.sp
                                              : 5.sp),
                                      height: 60.sp,
                                      child: Container(
                                        height: 20.sp,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3.sp),
                                            color:
                                                "${partialRequestHistoryModelController!.orders?[index - 1].status}" ==
                                                        "-1"
                                                    ? redColor
                                                    : greenColor),
                                        child: MyText(
                                          text:
                                              partialRequestHistoryModelController!
                                                          .orders![index - 1]
                                                          .status ==
                                                      1
                                                  ? "Cleared"
                                                  : "UnCleared",
                                          color: Colors.white,
                                          size: 11.sp,
                                        ),
                                      ),
                                    ),
                                  ])));
              }
              if (state is PartialHistoryRequestLoadingState) {
                return Center(
                  child: loadingIndicator(),
                );
              }
              if (state is PartialHistoryRequestNoDataState) {
                return Column(
                  children: [
                    Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      // columnWidths: {
                      //   0: FlexColumnWidth(80.sp),
                      //   1: FlexColumnWidth(70.sp),
                      //   2: FlexColumnWidth(50.sp),
                      //   // 3: FlexColumnWidth(90.sp),
                      //   4: FlexColumnWidth(110.sp),
                      //   5: FlexColumnWidth(90.sp)
                      // },
                      border: TableBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.sp)),
                          top: BorderSide(color: loginBtnColor, width: 0.2.sp),
                          left: BorderSide(color: loginBtnColor, width: 0.2.sp),
                          right:
                              BorderSide(color: loginBtnColor, width: 0.2.sp),
                          bottom:
                              BorderSide(color: loginBtnColor, width: 0.2.sp)),
                      children: [
                        TableRow(
                            decoration: const BoxDecoration(
                              color: lightGray,
                            ),
                            children: [
                              TitleRowCellComponent(
                                text: 'Driver Name'.tr(),
                                height: 60.sp,
                              ),
                              TitleRowCellComponent(
                                text: 'Shop Name'.tr(),
                                height: 60.sp,
                              ),
                              TitleRowCellComponent(
                                text: 'Order Item'.tr(),
                                height: 60.sp,
                              ),
                              // TitleRowCellComponent(
                              //   text: 'Amount to pay'.tr(),
                              //   height: 60.sp,
                              // ),
                              TitleRowCellComponent(
                                text: 'Request Date'.tr(),
                                height: 60.sp,
                              ),
                              TitleRowCellComponent(
                                text: 'Action'.tr(),
                                height: 60.sp,
                              ),
                            ])
                      ],
                    ),
                    150.ph,
                    const EmptyData()
                  ],
                );
              }
              if (state is PartialHistoryRequestNoInternetState) {
                return Center(
                  child: NoInternetWidget(onTap: () {
                    context
                        .read<PartialHistoryRequestCubit>()
                        .fetchHistoryRequest();
                  }),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
