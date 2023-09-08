import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/agentDashboardCubit/agent_dashboard_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/allCustomerCubit/all_customer_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/loginAsCustomerCubit/login_as_customer_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/loginAsCustomerCubit/login_as_customer_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/allCustomer/componenets/all_customer_state_component.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/payLaterRequestView/components/title_row_cell_component.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_text.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/empty_state.dart';
import 'package:tojjar_delivery_app/commonWidgets/no_internet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../DELIVERY/Utils/dynamic_link.dart';
import '../../../../DELIVERY/Utils/strings.dart';
import '../../../controller/cubits/allCustomerCubit/all_customer_state.dart';
import '../../../data/dataController/data_controller.dart';
import '../../../utils/images_url.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/rounded_btn_widget.dart';
import '../payLaterRequestView/components/row_cell_component.dart';

class AllCustomersView extends StatefulWidget {
  const AllCustomersView({super.key});

  @override
  State<AllCustomersView> createState() => _AllCustomersViewState();
}

class _AllCustomersViewState extends State<AllCustomersView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AllCustomerCubit>().fetchAllCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<AgentDashboardCubit>().fetchAgentDashboard();
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: scaffoldColor,
          appBar: CustomAppBar(
            onPressed: () {
              context.read<AgentDashboardCubit>().fetchAgentDashboard();
              Navigator.pop(context);
            },
            titleColor: textDarkColor,
            appBarColor: scaffoldColor,
            parentContext: context,
            leadingSize: 23.sp,
            titleSize: 18.sp,
            title: BlocBuilder<AllCustomerCubit, AllCustomerState>(
              builder: (context, state) {
                if (state is AllCustomerLoadedState) {
                  return MyText(
                    text: "All Customers".tr() +
                        "(${allCustomerModelController!.customers!.length})"
                            .tr(),
                    size: 18.sp,
                    weight: FontWeight.bold,
                    color: textDarkColor,
                  );
                }
                return MyText(
                  text: "${"All Customers".tr()} (0)",
                  size: 18.sp,
                  weight: FontWeight.bold,
                  color: textDarkColor,
                );
              },
            ),
            action: [
              Container(
                height: 36.sp,
                padding: EdgeInsets.only(
                    top: 15.sp,
                    right: 10.sp,
                    left: context.locale.languageCode == 'en' ? 0.sp : 10.sp),
                width: 180.sp,
                child: RoundedBtnWidget(
                    textWeight: FontWeight.w600,
                    widget: MyText(
                      text: "Add Customer".tr(),
                      size: 16.sp,
                      weight: FontWeight.w600,
                    ),
                    color: loginBtnColor,
                    onPressed: () {
                      Navigator.pushNamed(context, Strings.addCustomer);
                    }),
              )
            ],
          ),
          body: BlocListener<LoginAsCustomerCubit, LoginAsCustomerState>(
              listener: (context, state) async {
            if (state is LoginAsCustomerLoadingState) {
              await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: loadingIndicator(),
                    );
                  });
            }
            if (state is LoginAsCustomerLoadedState) {
              var encodeData = jsonEncode(loginCustomerController);
              var url = await DynamicLink.createLink(encodeData);

              await launchUrl(Uri.parse(url),
                  mode: LaunchMode.externalApplication);
              Navigator.pop(context);
            }
            if (state is LoginAsCustomerErrorState) {
              Navigator.pop(context);
            }
          }, child: BlocBuilder<AllCustomerCubit, AllCustomerState>(
                  builder: (context, state) {
            if (state is AllCustomerLoadedState) {
              return ListView(
                padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 24.sp),
                children: [
                  Table(
                    columnWidths: const {
                      // 0: FlexColumnWidth(120.sp),
                      // 1: FlexColumnWidth(120.sp),
                      // 2: FlexColumnWidth(120.sp),
                      // 3: FlexColumnWidth(80.sp)
                    },
                    border: TableBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.sp)),
                        top: BorderSide(color: loginBtnColor, width: 0.2.sp),
                        left: BorderSide(color: loginBtnColor, width: 0.2.sp),
                        right: BorderSide(color: loginBtnColor, width: 0.2.sp),
                        bottom:
                            BorderSide(color: loginBtnColor, width: 0.2.sp)),
                    // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children:
                        // [
                        List.generate(
                            allCustomerModelController!.customers!.length + 1,
                            (index) => index == 0
                                ? TableRow(
                                    decoration: const BoxDecoration(
                                      color: lightGray,
                                    ),
                                    children: [
                                        TitleRowCellComponent(
                                            text: "Customer".tr(),
                                            height: 50.sp),
                                        TitleRowCellComponent(
                                            text: 'Shop Name'.tr(),
                                            height: 50.sp),
                                        TitleRowCellComponent(
                                            text: 'Phone'.tr(), height: 50.sp),
                                        TitleRowCellComponent(
                                            text: 'Details'.tr(),
                                            height: 50.sp),
                                      ])
                                : TableRow(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.5.sp,
                                                color: Colors.grey))),
                                    children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: MySharedPrefs.getLocale() ==
                                                      true
                                                  ? 15.sp
                                                  : 0.sp,
                                              right:
                                                  MySharedPrefs.getLocale() ==
                                                          true
                                                      ? 0.sp
                                                      : 5.sp,
                                              top: 15.sp,
                                              bottom: 5.sp),
                                          // height: 60.sp,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText(
                                                text:
                                                    allCustomerModelController!
                                                            .customers![
                                                                index - 1]
                                                            .name ??
                                                        "",
                                                size: 13.sp,
                                                weight: FontWeight.w600,
                                                color: textDarkColor,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  // print("tap");
                                                  context
                                                      .read<
                                                          LoginAsCustomerCubit>()
                                                      .fetchLoginAsCustomer(
                                                          allCustomerModelController!
                                                              .customers![
                                                                  index - 1]
                                                              .userId);
                                                },
                                                child: Row(
                                                  children: [
                                                    MyText(
                                                      text: "Login".tr(),
                                                      size: 13.sp,
                                                      color: yellowDark,
                                                    ),
                                                    4.pw,
                                                    SvgPicture.asset(signInSvg)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        RowCellComponent(
                                          text: allCustomerModelController!
                                              .customers![index - 1].shopName
                                              .toString(),
                                          tag: "customer",
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 15.sp,
                                              top: 15.sp,
                                              bottom: 5.sp),
                                          alignment: Alignment.centerLeft,
                                          // height: 60.sp,
                                          child: MyText(
                                            text: allCustomerModelController!
                                                    .customers![index - 1]
                                                    .phone ??
                                                "",
                                            size: 13.sp,
                                            color: textDarkColor,
                                          ),
                                        ),
                                        Container(
                                          // height: 60.sp,
                                          padding: EdgeInsets.only(
                                              left: 15.sp,
                                              top: 6.sp,
                                              bottom: 5.sp),
                                          child: IconButton(
                                              alignment: Alignment.topCenter,
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    Strings
                                                        .singleCustomerDetail,
                                                    arguments:
                                                        allCustomerModelController!
                                                            .customers![
                                                                index - 1]
                                                            .userId);
                                              },
                                              icon: Icon(
                                                Icons.visibility_outlined,
                                                color: loginBtnColor,
                                                size: 20.sp,
                                              )),
                                        )
                                      ])),
                  )
                ],
              );
            }
            if (state is AllCustomerLoadingState) {
              return Center(
                child: loadingIndicator(),
              );
            }
            if (state is AllCustomerNoDataState) {
              return const AllCustomerStateComponent(
                state: EmptyData(),
              );
            }
            if (state is AllCustomerNoInternetState) {
              return AllCustomerStateComponent(
                  state: NoInternetWidget(onTap: () {
                context.read<AllCustomerCubit>().fetchAllCustomer();
              }));
            }

            return const SizedBox();
          }))),
    );
  }
}
