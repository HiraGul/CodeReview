import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/logout.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/agentDashboardCubit/agent_dashboard_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/getCheckInCubit/get_checkin_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/models/checkin_model.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/notification_timer.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/saleAgentDashboard/components/pay_request_component.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_text.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/rounded_btn_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/empty_state.dart';
import 'package:tojjar_delivery_app/commonWidgets/no_internet.dart';
import 'package:tojjar_delivery_app/commonWidgets/user_not_authorize.dart';

import '../../../../DELIVERY/Data/Models/login_model.dart';
import '../../../../DELIVERY/Utils/strings.dart';
import '../../../controller/cubits/agentDashboardCubit/agent_dashboard_state.dart';
import '../../../controller/cubits/customerCheckinCubit/customer_checkin_cubit.dart';
import '../../../data/dataController/data_controller.dart';
import '../../../utils/images_url.dart';
import '../../widgets/round_container_btn.dart';
import 'components/check_in_component.dart';
import 'components/check_out_component.dart';

class SaleAgentDashBoard extends StatefulWidget {
  const SaleAgentDashBoard({
    super.key,
  });

  @override
  State<SaleAgentDashBoard> createState() => _SaleAgentDashBoardState();
}

class _SaleAgentDashBoardState extends State<SaleAgentDashBoard> {
  var listen = ValueNotifier<bool>(false);
  NotificationTimer notificationTimer = NotificationTimer();

  @override
  void initState() {
    super.initState();

    // getCheckIn();

    context.read<AgentDashboardCubit>().fetchAgentDashboard();

    context.read<CustomerCheckInCubit>().fetchCustomerCheckInData();
    context.read<GetCheckInCubit>().fetchGetCheckInData();

    // SchedulerBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    CheckInModel? checkInModel = MySharedPrefs.getCheckInData();
    if (checkInModel?.data == null) {
      listen.value = false;
    } else {
      listen.value = true;
    }
    var user = MySharedPrefs.getUser();
    await FirebaseMessaging.instance
        .subscribeToTopic('PayLaterRequest-${user!.user!.id}');
    await FirebaseMessaging.instance
        .subscribeToTopic('PartialPaymentRequest-${user.user!.id}');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<GetCheckInCubit>().fetchGetCheckInData();
            context.read<AgentDashboardCubit>().fetchAgentDashboard();
          },
          child: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: BlocBuilder<AgentDashboardCubit, AgentDashboardState>(
              builder: (context, state) {
                if (state is AgentDashboardLoadingState) {
                  return Center(
                    child: loadingIndicator(),
                  );
                }
                if (state is AgentDashboardLoadedState) {
                  return ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.sp, vertical: 64.sp),
                    children: [
                      // AuthenticationLanguageDropDownButton(
                      //   context: context,
                      // ),
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       // String googleUrl =
                      //       //     'https://www.google.com/maps/search/?api=1&query=33.9746,71.4732';
                      //       String googleUrl =
                      //           "google.navigation:q=33.9746,71.4732&mode=d";
                      //       try {
                      //         await launchUrl(Uri.parse(googleUrl));
                      //       } catch (e) {
                      //         print("could not launch url");
                      //       }
                      //     },
                      //     child: const Text("Test map launcher")),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              // context.read<DriverLogoutCubit>().userLogout();
                              showAlertDialog(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.login_rounded,
                                  size: 23.sp,
                                  color: const Color(0xff707171),
                                ),
                                10.pw,
                                MyText(
                                  text: "Log out".tr(),
                                  size: 16.sp,
                                  color: const Color(0xff707171),
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      40.ph,
                      Align(
                        alignment: Alignment.center,
                        child: MyText(
                          text: "Sales Agent Dashboard".tr(),
                          size: 28.sp,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      29.ph,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.sp),
                            border: Border.all(color: borderColor)),
                        height: 94.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SvgPicture.asset(customersSvg),
                            SvgPicture.asset(customerSvg),
                            23.pw,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "Customers".tr(),
                                  size: 20.sp,
                                  weight: FontWeight.w500,
                                  color: textDarkColor,
                                ),
                                MyText(
                                  text: dashboardModelController!
                                      .data!.customers
                                      .toString(),
                                  size: 32.sp,
                                  weight: FontWeight.bold,
                                  color: greenColor,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      16.ph,
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(230, 230, 230, 1))),
                        height: 94.sp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SvgPicture.asset(ordersSvg),
                            SvgPicture.asset(orderSvg),
                            23.pw,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "Orders".tr(),
                                  size: 20.sp,
                                  weight: FontWeight.w500,
                                  color: textDarkColor,
                                ),
                                MyText(
                                  text: dashboardModelController!.data!.orders
                                      .toString(),
                                  size: 32.sp,
                                  weight: FontWeight.bold,
                                  color: greenColor,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      38.ph,
                      PayRequestComponent(
                        routeString: Strings.payLaterRequest,
                        buttonText: 'Pay Later Requests'.tr(),
                        color: greenColor,
                        requests: dashboardModelController!
                            .data!.totalPendingRequests
                            .toString(),
                      ),
                      18.ph,
                      PayRequestComponent(
                        routeString: Strings.partialPayRequest,
                        buttonText: 'Partial Pay Requests'.tr(),
                        color: redColor,
                        requests: dashboardModelController!
                            .data!.totalPartialPaymentPendingRequests
                            .toString(),
                      ),
                      18.ph,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 55.sp),
                        child: RoundedBtnWidget(
                            widget: MyText(
                              text: "View All Customers".tr(),
                              size: 20.sp,
                              weight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            color: loginBtnColor,
                            textSize: 20.sp,
                            onPressed: () {
                              Navigator.pushNamed(context, Strings.customers);
                            }),
                      ),
                      18.ph,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 55.sp),
                        child: RoundedBtnWidget(
                            widget: MyText(
                              text: "View All Orders".tr(),
                              size: 20.sp,
                              weight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            textSize: 20.sp,
                            color: orangeColor,
                            onPressed: () {
                              Navigator.pushNamed(context, Strings.allOrders);
                            }),
                      ),
                      18.ph,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 55.sp),
                        child: RoundContainerBtn(
                          textSize: 20.sp,
                          textWeight: FontWeight.w600,
                          text: 'Targets & Achievements'.tr(),
                          textColor: greenColor,
                          borderColor: greenColor,
                          onTap: () {
                            Navigator.pushNamed(
                                context, Strings.targetAcheivement);
                          },
                        ),
                      ),
                      // if listen value change, show the animation betwen checkin and checkout component
                      ValueListenableBuilder(
                          valueListenable: listen,
                          builder: (context, value, child) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: value ? 15.sp : 55.sp),
                              child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  reverseDuration: Duration.zero,
                                  transitionBuilder: (child, animation) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                              begin: const Offset(0, 0.1),
                                              end: const Offset(0, 0))
                                          .animate(animation),
                                      child: child,
                                    );
                                  },
                                  child: value
                                      ? CheckoutComponent(
                                          listen: listen,
                                          saleAgentContext: context,
                                          notificationTimer: notificationTimer,
                                        )
                                      : CheckInComponent(
                                          listen: listen,
                                          saleAgentContext: context,
                                          notificationTimer: notificationTimer,
                                        )),
                            );
                          })
                    ],
                  );
                }
                if (state is AgentDashboardNoDataState) {
                  return const Center(
                    child: EmptyData(),
                  );
                }
                if (state is AgentDashboardNoInternetState) {
                  return Center(
                    child: NoInternetWidget(onTap: () {
                      context.read<AgentDashboardCubit>().fetchAgentDashboard();
                    }),
                  );
                }
                if (state is AgentDashboardUnAuthorizeState) {
                  MySharedPrefs.setUser(LoginModel());
                  return const Center(child: UserNotAuthorized());
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
