import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/agentDashboardCubit/agent_dashboard_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialHistoryRequestCubit/partial_history_request_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialHistoryRequestCubit/partial_history_request_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPendingRequestCubit/partial_pending_request_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPendingRequestCubit/partial_pending_request_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/partialPayRequestView/partial_history_request_view.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/partialPayRequestView/partial_pending_request_view.dart';

class PartialPayRequestView extends StatefulWidget {
  const PartialPayRequestView({super.key});

  @override
  State<PartialPayRequestView> createState() => _PartialPayRequestViewState();
}

class _PartialPayRequestViewState extends State<PartialPayRequestView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // int selecetdIndex = 0;
  var selectedNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // context.read<RequestHistoryCubit>().fetchRequestHistory();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await context.read<AgentDashboardCubit>().fetchAgentDashboard();
        return Future.value(true);
      },
      child: ValueListenableBuilder(
          valueListenable: selectedNotifier,
          builder: (context, value, child) {
            return Scaffold(
              backgroundColor: scaffoldColor,
              appBar: AppBar(
                leadingWidth: 0,
                backgroundColor: scaffoldColor,
                elevation: 0,
                bottom: TabBar(
                    isScrollable: false,
                    onTap: (index) {
                      selectedNotifier.value = index;
                      if (index == 0) {
                        context
                            .read<PartialPendingRequestCubit>()
                            .fetchPendingRequest();
                      } else {
                        context
                            .read<PartialHistoryRequestCubit>()
                            .fetchHistoryRequest();
                      }
                      // setState(() {});
                    },
                    overlayColor: MaterialStateProperty.all(Colors.white),
                    controller: tabController,
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                          height: 60.sp,
                          decoration: BoxDecoration(
                              color: value == 0 ? lightPinkColor : lightGray),
                          child: BlocBuilder<PartialPendingRequestCubit,
                              PartialPendingRequestState>(
                            builder: (context, state) {
                              if (state is PartialPendingRequestLoadedState) {
                                return RichText(
                                    text: TextSpan(
                                        text: "Pending".tr(),
                                        style: GoogleFonts.openSans(
                                            color: value == 0
                                                ? redColor
                                                : Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                      TextSpan(
                                          text:
                                              "   (${partialPendingRequestModelController!.requests!.length})",
                                          style: GoogleFonts.openSans(
                                              color: value == 0
                                                  ? redColor
                                                  : Colors.black,
                                              fontSize: 24.sp,
                                              fontWeight: FontWeight.bold))
                                    ]));
                              }
                              return RichText(
                                  text: TextSpan(
                                      text: "Pending".tr(),
                                      style: GoogleFonts.openSans(
                                          color: value == 0
                                              ? redColor
                                              : Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                    TextSpan(
                                        text: "   (0)",
                                        style: GoogleFonts.openSans(
                                            color: value == 0
                                                ? redColor
                                                : Colors.black,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold))
                                  ]));
                            },
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                        height: 60.sp,
                        decoration: BoxDecoration(
                            color: value == 1 ? loginBtnColor : lightGray),
                        child: BlocBuilder<PartialHistoryRequestCubit,
                            PartialHistoryRequestState>(
                          builder: (context, state) {
                            if (state is PartialHistoryRequestLoadedState) {
                              return RichText(
                                  text: TextSpan(
                                      text: "History".tr(),
                                      style: GoogleFonts.openSans(
                                          color: value == 1
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                    TextSpan(
                                        text:
                                            "   (${partialRequestHistoryModelController!.orders!.length})",
                                        style: GoogleFonts.openSans(
                                            color: value == 1
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold))
                                  ]));
                            }
                            return RichText(
                                text: TextSpan(
                                    text: "History".tr(),
                                    style: GoogleFonts.openSans(
                                        color: value == 1
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                  TextSpan(
                                      text: "   (0)",
                                      style: GoogleFonts.openSans(
                                          color: value == 1
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold))
                                ]));
                          },
                        ),
                      ),
                    ]),
              ),
              body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: const [
                    PartialPendingRequestView(),
                    PartialHistoryRequestView()
                  ]),
            );
          }),
    );
  }
}
