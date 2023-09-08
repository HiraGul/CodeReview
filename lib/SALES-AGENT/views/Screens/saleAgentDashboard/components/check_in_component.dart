import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/checkInCubit/checkin_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/customerCheckinCubit/customer_checkin_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/determine_position.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/images_url.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/message.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/notification_timer.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';

import '../../../../../commonWidgets/LoadingWidget.dart';
import '../../../../controller/cubits/checkInCubit/checkin_cubit.dart';
import '../../../../controller/cubits/customerCheckinCubit/customer_checkin_state.dart';
import '../../../../data/dataController/data_controller.dart';
import '../../../../data/models/customer_checkin_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../widgets/my_drop_down_button.dart';
import '../../../widgets/my_text.dart';
import '../../../widgets/round_container_btn.dart';
import '../../../widgets/rounded_btn_widget.dart';

class CheckInComponent extends StatelessWidget {
  CheckInComponent(
      {super.key,
      required this.listen,
      required this.saleAgentContext,
      required this.notificationTimer});

  final ValueNotifier listen;
  final BuildContext saleAgentContext;
  NotificationTimer notificationTimer;

//customer data
  Datum? datum;
  var currentLocation = ValueNotifier<Position>(const Position(
      longitude: 23.8859,
      latitude: 45.0792,
      timestamp: null,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0));

  var checkinLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey<bool>(listen.value),
      children: [
        InkWell(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    return _alertDialog(context);
                  });
            },
            child:
                //  SvgPicture.asset(
                //   forwardArrowSvg,
                // ),
                Image.asset(forwardArrowPng)),
        14.ph,
        Align(
          alignment: Alignment.center,
          child: MyText(
            text: "Check In".tr(),
            size: 20.sp,
            weight: FontWeight.w600,
            color: loginBtnColor,
          ),
        ),
        // 5.ph,
        // Container(
        //   // height: 40.sp,
        //   // width: double.infinity,
        //   padding: EdgeInsets.symmetric(horizontal: 94.sp),
        //   child: MyText(
        //       textAlign: TextAlign.center,
        //       color: mediumGrayColor,
        //       text:
        //           'Please tap the Button to check in and start adding customers.'
        //               .tr(),
        //       size: 14.sp),
        // ),
      ],
    );
  }

  _alertDialog(context) {
    return AlertDialog(
      title:
          // SvgPicture.asset(errorSvg),
          SvgPicture.asset(errorSvg),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyText(
            text: 'Enter Current Shop Name'.tr(),
            size: 20.sp,
            weight: FontWeight.w600,
            color: loginBtnColor,
          ),
          3.ph,
          MyText(
            text: 'Please enter shop where you are now!'.tr(),
            size: 12.sp,
            color: mediumGrayColor,
          ),
          16.ph,
          BlocBuilder<CustomerCheckInCubit, CustomerCheckInState>(
            builder: (context, state) {
              if (state is CustomerCheckInLoadingState) {
                return loadingIndicator();
              }
              if (state is CustomerCheckInLoadedState) {
                return MyDropDownButton(
                  items: customerCheckInModelController!.data!,
                  onChange: (value, data) {
                    datum = data;
                  },
                  hint: 'Al-Madina Shop'.tr(),
                );
              }
              if (state is CustomerCheckInErrorState) {
                return Text("something went wrong".tr());
              }
              return MyDropDownButton(
                items: const [],
                onChange: (value, data) {},
                hint: "Al-Madina Shop".tr(),
              );
            },
          )
        ],
      ),
      titlePadding: EdgeInsets.only(top: 33.sp),
      contentPadding:
          EdgeInsets.only(left: 45.sp, right: 44.sp, top: 20.sp, bottom: 26.sp),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.only(
        bottom: 21.sp,
      ),
      actions: [
        SizedBox(
          height: 43.sp,
          width: 135.sp,
          child: RoundContainerBtn(
              textSize: 16.sp,
              textWeight: FontWeight.w400,
              onTap: () {
                Navigator.pop(context);
              },
              textColor: grayColor,
              borderColor: grayColor,
              text: 'Cancel'.tr()),
        ),
        BlocListener<CheckInCubit, CheckInState>(
          listener: (context, state) async {
            if (state is CheckInLoadedState) {
              listen.value = true;

              //start the periodic notification
              notificationTimer.startTimer();

              Timer(const Duration(milliseconds: 500), () {
                Navigator.pop(context);
              });
            }
            if (state is CheckInNoInternetState) {
              Navigator.pop(context);
              showMessage(context, "no internet connection".tr());
            }
            if (state is CheckInBadRequest) {
              Navigator.pop(context);
              showMessage(context, checkInErrorModel!.message);
            }
          },
          child: SizedBox(
            height: 43.sp,
            width: 135.sp,
            child: RoundedBtnWidget(
                widget: ValueListenableBuilder(
                    valueListenable: checkinLoading,
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
                          text: "Check In".tr(),
                          size: 16.sp,
                          color: Colors.white,
                        );
                      }
                    }),
                color: loginBtnColor,
                onPressed: () async {
                  if (datum != null) {
                    checkinLoading.value = !checkinLoading.value;
                    await MySharedPrefs.setCustomerData(datum!);
                    var date = DateTime.now();
                    final timeFormat = DateFormat.Hms(); // Format for time
                    final dateFormat =
                        DateFormat('yyyy-MM-dd'); // Format for date

                    final formattedTime = timeFormat.format(date);
                    final formattedDate = dateFormat.format(date);

                    final formattedDateTime = '$formattedDate $formattedTime';
                    await determinePosition(currentLocation);

                    //check the distance limit for checkin and out
                    var distanceDifference = Geolocator.distanceBetween(
                      currentLocation.value.latitude,
                      currentLocation.value.longitude,
                      datum!.latitude,
                      datum!.longitude,
                    );
                    var location =
                        "${currentLocation.value.latitude},${currentLocation.value.longitude}";

                    if (distanceDifference <= 800) {
                      saleAgentContext.read<CheckInCubit>().fetchCheckInData(
                          saleAgentContext,
                          datum!.id,
                          datum!.userId,
                          formattedDateTime,
                          location);
                      checkinLoading.value = !checkinLoading.value;
                    } else {
                      Navigator.pop(context);
                      showMessage(
                          context, "you exceed the distance limit".tr());
                      checkinLoading.value = !checkinLoading.value;
                    }
                  }
                }),
          ),
        )
      ],
    );
  }
}
