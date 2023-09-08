import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/agentDashboardCubit/agent_dashboard_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPendingRequestCubit/partial_pending_request_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPendingRequestCubit/partial_pending_request_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/payLaterRequestView/components/row_cell_component.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/payLaterRequestView/components/title_row_cell_component.dart';
import 'package:tojjar_delivery_app/commonWidgets/empty_state.dart';

import '../../../../DELIVERY/Utils/strings.dart';
import '../../../../commonWidgets/LoadingWidget.dart';
import '../../../../commonWidgets/no_internet.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/my_rich_text.dart';
import '../../widgets/my_text.dart';

class PartialPendingRequestView extends StatefulWidget {
  const PartialPendingRequestView({super.key});

  @override
  State<PartialPendingRequestView> createState() =>
      _PartialPendingRequestViewState();
}

class _PartialPendingRequestViewState extends State<PartialPendingRequestView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PartialPendingRequestCubit>().fetchPendingRequest();
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
            BlocBuilder<PartialPendingRequestCubit, PartialPendingRequestState>(
          builder: (context, state) {
            return MyRichText(
              firstText: "Pending Request".tr(),
              secondText: partialPendingRequestModelController != null
                  ? "${partialPendingRequestModelController!.requests!.length}"
                  : "0",
              firstSize: 16.sp,
              secondSize: 18.sp,
              firstColor: textDarkColor,
              firstWeight: FontWeight.w600,
              secondWeight: FontWeight.w600,
              secondColor: loginBtnColor,
            );
          },
        ),
        leading: IconButton(
            onPressed: () {
              context.read<AgentDashboardCubit>().fetchAgentDashboard();
              // Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, Strings.saleAgentDashboard, (route) => false);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 25.sp,
            )),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
          children: [
            BlocBuilder<PartialPendingRequestCubit, PartialPendingRequestState>(
              builder: (context, state) {
                if (state is PartialPendingRequestLoadedState) {
                  return Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      // columnWidths: {
                      //   0: FlexColumnWidth(80.sp),
                      //   1: FlexColumnWidth(70.sp),
                      //   2: FlexColumnWidth(50.sp),
                      //   3: FlexColumnWidth(90.sp),
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
                      children: List.generate(
                          partialPendingRequestModelController!
                                  .requests!.length +
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
                              : TableRow(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.1.sp,
                                              color: Colors.grey))),
                                  children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                Strings
                                                    .partialPayRequestApproval,
                                                arguments: index - 1);
                                          },
                                          child: RowCellComponent(
                                              text:
                                                  '${partialPendingRequestModelController!.requests![index - 1].driverName}')),
                                      InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                Strings
                                                    .partialPayRequestApproval,
                                                arguments: index - 1);
                                          },
                                          child: RowCellComponent(
                                              text:
                                                  " ${partialPendingRequestModelController!.requests![index - 1].shopName}")),
                                      InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                Strings
                                                    .partialPayRequestApproval,
                                                arguments: index - 1);
                                          },
                                          child: RowCellComponent(
                                              text:
                                                  '${partialPendingRequestModelController!.requests![index - 1].orderItems}')),
                                      // InkWell(
                                      //     onTap: () {
                                      //       Navigator.pushNamed(
                                      //           context,
                                      //           Strings
                                      //               .partialPayRequestApproval,
                                      //           arguments: index - 1);
                                      //     },
                                      //     child: RowCellComponent(
                                      //         text:
                                      //             "${partialPendingRequestModelController!.requests![index - 1].amountToPay} SAR")),
                                      InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context,
                                                Strings
                                                    .partialPayRequestApproval,
                                                arguments: index - 1);
                                          },
                                          child: RowCellComponent(
                                              text:
                                                  '${partialPendingRequestModelController!.requests![index - 1].requestDate}')),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              Strings.partialPayRequestApproval,
                                              arguments: index - 1);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              right: 5.sp,
                                              top: 10.sp,
                                              left:
                                                  context.locale.languageCode ==
                                                          'en'
                                                      ? 0.sp
                                                      : 5.sp),
                                          height: 60.sp,
                                          child: Container(
                                            height: 20.sp,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: inProcessColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        3.sp)),
                                            child: MyText(
                                              text: 'Pending'.tr(),
                                              size: 11.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ])));
                }
                if (state is PartialPendingRequestLoadingState) {
                  return Center(
                    child: loadingIndicator(),
                  );
                }
                if (state is PartialPendingRequestNoInternetState) {
                  return Center(
                    child: NoInternetWidget(onTap: () {
                      context
                          .read<PartialPendingRequestCubit>()
                          .fetchPendingRequest();
                    }),
                  );
                }
                if (state is PartialPendingRequestNoDataState) {
                  return Column(
                    children: [
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        // columnWidths: {
                        //   0: FlexColumnWidth(80.sp),
                        //   1: FlexColumnWidth(70.sp),
                        //   2: FlexColumnWidth(50.sp),
                        //   3: FlexColumnWidth(90.sp),
                        //   4: FlexColumnWidth(110.sp),
                        //   5: FlexColumnWidth(90.sp)
                        // },
                        border: TableBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.sp)),
                            top:
                                BorderSide(color: loginBtnColor, width: 0.2.sp),
                            left:
                                BorderSide(color: loginBtnColor, width: 0.2.sp),
                            right:
                                BorderSide(color: loginBtnColor, width: 0.2.sp),
                            bottom: BorderSide(
                                color: loginBtnColor, width: 0.2.sp)),
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
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
