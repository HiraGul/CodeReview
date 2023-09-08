import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_text_field.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/checkOutCubit/checkout_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/checkOutCubit/checkout_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/getCheckInCubit/get_checkin_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/getCheckInCubit/get_checkin_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/models/checkin_model.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/global_field_and_variable.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/images_url.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/notification_timer.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:tojjar_delivery_app/commonWidgets/no_internet.dart';
import 'package:tojjar_delivery_app/push_notification/local_notification_service.dart';

import '../../../../data/models/customer_checkin_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/determine_position.dart';
import '../../../../utils/message.dart';
import '../../../widgets/my_text.dart';
import '../../../widgets/round_container_btn.dart';
import '../../../widgets/rounded_btn_widget.dart';

class CheckoutComponent extends StatelessWidget {
  CheckoutComponent(
      {super.key,
      required this.listen,
      required this.saleAgentContext,
      required this.notificationTimer});

  final ValueNotifier listen;
  final BuildContext saleAgentContext;
  NotificationTimer notificationTimer;

  var currentLocation = ValueNotifier<Position>(const Position(
      longitude: 23.8859,
      latitude: 45.0792,
      timestamp: null,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0));
  var checkoutLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCheckInCubit, GetCheckInState>(
      builder: (context, state) {
        if (state is GetCheckInLoadingState) {
          return loadingIndicator();
        }
        if (state is GetCheckInLoadedState) {
          final timeFormat = DateFormat.jm();
          var formatedTime =
              timeFormat.format(getCheckInModelController!.data!.checkedIn!);
          return Column(
            key: ValueKey<bool>(listen.value),
            children: [
              // SvgPicture.asset(roundCheckBoxSvg),
              Image.asset(roundCheckedPng),
              14.ph,
              MyText(
                text: 'Checked In'.tr(),
                size: 20.sp,
                color: loginBtnColor,
              ),
              5.ph,
              MyText(
                text: 'Checked in at'.tr(),
                size: 14.sp,
                color: labelColor,
              ),
              5.ph,
              MyText(
                text: formatedTime,
                size: 18.sp,
                color: greenColor,
              ),
              10.ph,
              MyText(
                text: 'Current Shop Name'.tr(),
                size: 16.sp,
                color: labelColor,
              ),
              MyText(
                text: '${getCheckInModelController!.data!.shopName}',
                size: 16.sp,
                weight: FontWeight.w500,
                color: loginBtnColor,
              ),
              16.ph,
              InkWell(
                onTap: () {
                  _showDialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SvgPicture.asset(logoutSvg),
                    SvgPicture.asset(logoutSvg),
                    10.pw,
                    MyText(
                      text: 'Check Out'.tr(),
                      size: 20.sp,
                      color: yellowDark,
                    )
                  ],
                ),
              )
            ],
          );
        }
        if (state is GetCheckInNoInternetState) {
          return NoInternetWidget(onTap: () {});
        }
        if (state is GetCheckInErrorState) {
          return ErrorWidget(state.error.toString());
        }
        return const SizedBox();
      },
    );
  }

  _showDialog(context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: SvgPicture.asset(infoSvg),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  text: 'Confirm Checkout'.tr(),
                  size: 20.sp,
                  weight: FontWeight.w600,
                  color: loginBtnColor,
                ),
                3.ph,
                MyText(
                  text: 'Please write your reason confirm your checkout'.tr(),
                  size: 12.sp,
                  color: mediumGrayColor,
                ),
                Container(
                    margin: EdgeInsets.all(10.sp),
                    padding: EdgeInsets.all(10.sp),
                    child: CustomTextField(
                        maxLines: 5,
                        textInputType: TextInputType.multiline,
                        hintText: "Reason".tr(),
                        controller: checkoutReason))
              ],
            ),
            titlePadding: EdgeInsets.only(top: 20.sp),
            contentPadding: EdgeInsets.only(
              top: 20.sp,
              bottom: 20.sp,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: EdgeInsets.only(bottom: 24.sp),
            actions: [
              SizedBox(
                height: 43.sp,
                width: 135.sp,
                child: RoundContainerBtn(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    textColor: labelColor,
                    borderColor: labelColor,
                    text: 'Cancel'.tr()),
              ),
              BlocListener<CheckOutCubit, CheckOutState>(
                listener: (context, state) {
                  if (state is CheckOutLoadedState) {
                    notificationTimer.endTimer();
                    MyNotificationService.removeSingleNotifications(id: 0);
                    listen.value = false;
                    MySharedPrefs.setCheckInData(CheckInModel());
                    Navigator.pop(context);
                    showMessage(
                        saleAgentContext, "successfully check out".tr());
                  }
                },
                child: SizedBox(
                  height: 43.sp,
                  width: 135.sp,
                  child: RoundedBtnWidget(
                      widget: ValueListenableBuilder(
                          valueListenable: checkoutLoading,
                          builder: (context, value, child) {
                            if (value) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.sp, horizontal: 10.sp),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            } else {
                              return MyText(
                                text: "Check Out".tr(),
                                size: 16.sp,
                                color: Colors.white,
                              );
                            }
                          }),
                      color: loginBtnColor,
                      onPressed: () async {
                        if (checkoutReason.text.isEmpty) {
                          Navigator.pop(context);
                          showMessage(
                              context, "Please write reason to check out".tr());
                        } else {
                          // var checkInData = MySharedPrefs.getCheckInData();
                          checkoutLoading.value = !checkoutLoading.value;
                          var date = DateTime.now();
                          final timeFormat =
                              DateFormat.Hms(); // Format for time
                          final dateFormat =
                              DateFormat('yyyy-MM-dd'); // Format for date

                          final formattedTime = timeFormat.format(date);
                          final formattedDate = dateFormat.format(date);

                          final formattedDateTime =
                              '$formattedDate $formattedTime';
                          await determinePosition(currentLocation);
                          Datum? customerData =
                              await MySharedPrefs.getCustomerData();
                          var distanceDifference = Geolocator.distanceBetween(
                              currentLocation.value.latitude,
                              currentLocation.value.longitude,
                              customerData!.latitude,
                              customerData.longitude);
                          var location =
                              "${currentLocation.value.latitude},${currentLocation.value.longitude}";

                          if (distanceDifference <= 800) {
                            saleAgentContext
                                .read<CheckOutCubit>()
                                .fetchCheckOutData(formattedDateTime, location);
                            checkoutLoading.value = !checkoutLoading.value;
                          } else {
                            Navigator.pop(context);
                            showMessage(
                                context, "you exceed the distance limit".tr());
                            checkoutLoading.value = !checkoutLoading.value;
                          }
                        }
                      }),
                ),
              )
            ],
          );
        });
  }
}
