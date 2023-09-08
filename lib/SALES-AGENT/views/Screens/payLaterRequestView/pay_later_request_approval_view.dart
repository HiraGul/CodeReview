import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/pendingRequestCubit/pending_request_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/fcm_repo.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/info_detail_row.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_form_field.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/rounded_btn_widget.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/success_card.dart';
import 'package:tojjar_delivery_app/commonWidgets/FlutterToast.dart';

import '../../../../DELIVERY/Utils/strings.dart';
import '../../../controller/cubits/payLaterRequestApprovCubit/pay_later_request_approve_cubit.dart';
import '../../../controller/cubits/payLaterRequestApprovCubit/pay_later_request_approve_state.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/images_url.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_configuration_dialog.dart';
import '../../widgets/my_text.dart';

class PayLaterRequestApprovalView extends StatelessWidget {
  PayLaterRequestApprovalView({super.key});

  var loading = ValueNotifier<bool>(false);
  var hourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var index = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        leadingSize: 25.sp,
        parentContext: context,
        title: MyText(
          text: 'Pay Later Request'.tr(),
          size: 16.sp,
          weight: FontWeight.w600,
          color: appBarTitleColor,
        ),
        titleColor: appBarTitleColor,
        titleSize: 16.sp,
        titleWeight: FontWeight.w600,
      ),
      body: Container(
        height: 308.sp,
        margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 7.sp),
        padding: EdgeInsets.only(left: 26.sp, top: 20.sp, right: 20.sp),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: loginBtnColor, width: 0.1.sp)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoDetailRow(
              tag: 'Driver Name'.tr(),
              info: "Shop Name".tr(),
              tagColor: payLaterTextColor,
              tagSize: 16.sp,
              infoColor: payLaterTextColor,
              infoSize: 16.sp,
              tagFlex: 1,
              infoFlex: 1,
            ),
            10.ph,
            InfoDetailRow(
              tag:
                  '${pendingRequestModelController!.requests![index].driverName}',
              info:
                  "${pendingRequestModelController!.requests![index].shopName}",
              tagColor: forgetTextColor,
              tagSize: 16.sp,
              infoColor: forgetTextColor,
              infoSize: 16.sp,
              tagFlex: 1,
              infoFlex: 1,
            ),
            16.ph,
            InfoDetailRow(
              tag: 'Ordered Items'.tr(),
              info: "Amount To Pay".tr(),
              tagColor: payLaterTextColor,
              tagSize: 16.sp,
              infoColor: payLaterTextColor,
              infoSize: 16.sp,
              tagFlex: 1,
              infoFlex: 1,
            ),
            10.ph,
            InfoDetailRow(
              tag:
                  '${pendingRequestModelController!.requests![index].orderItems}',
              info:
                  "${pendingRequestModelController!.requests![index].amountToPay}",
              tagColor: forgetTextColor,
              tagSize: 16.sp,
              infoColor: forgetTextColor,
              infoSize: 16.sp,
              tagFlex: 1,
              infoFlex: 1,
            ),
            16.ph,
            MyText(text: 'Date'.tr(), size: 16.sp),
            10.ph,
            MyText(
              text:
                  '${pendingRequestModelController!.requests![index].requestDate}',
              size: 16.sp,
              color: labelColor,
            ),
            28.ph,
            SizedBox(
              height: 36.sp,
              child: Row(
                children: [
                  Expanded(
                      child: RoundedBtnWidget(
                          widget: MyText(
                            text: "Approve".tr(),
                            size: 16.sp,
                            weight: FontWeight.w600,
                          ),
                          color: greenColor,
                          onPressed: () {
                            // alert dialog
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) {
                                  return _alertDialog(context, loading,
                                      id: pendingRequestModelController!
                                          .requests![index].id,
                                      orderId: pendingRequestModelController!
                                          .requests![index].orderId);
                                });
                          })),
                  12.pw,
                  Expanded(
                      child: RoundedBtnWidget(
                          widget: MyText(
                            text: "Reject".tr(),
                            size: 16.sp,
                            weight: FontWeight.w600,
                          ),
                          color: redColor,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return rejectDialog(context,
                                      id: pendingRequestModelController!
                                          .requests![index].id,
                                      orderId: pendingRequestModelController!
                                          .requests![index].orderId);
                                });
                          }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _alertDialog(BuildContext context, ValueNotifier loading, {id, orderId}) {
    return BlocListener<PayLaterRequestApproveCubit,
        PayLaterRequestApproveState>(
      listener: (context, state) async {
        if (state is PayLaterRequestApproveLoadedState) {
          // Navigator.of(context).pop();
          // await Future.delayed(const Duration(seconds: 1));

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: SuccessCard(
                      title: 'Pay Later Request Approved'.tr(),
                      description:
                          'Request for pay later has been Approved. confirmation sent to driver'
                              .tr()),
                );
              });
          FcmRepo().sendNotification(
              id,
              orderId,
              'payLaterRequestResponse',
              "Pay Later Request Accepted",
              "Your Request for Pay Later has been Accepted",
              "signaturePayLater");

          await Future.delayed(
            const Duration(seconds: 1),
            () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Strings.payLaterRequest));
            },
          );
          context.read<PendingRequestCubit>().fetchPendingRequest();
          loading.value = false;
        }
      },
      child: AlertDialog(
        actionsPadding:
            EdgeInsets.only(bottom: 20.sp, left: 23.sp, right: 23.sp),
        actions: [
          SizedBox(
            height: 40.sp,
            child: RoundedBtnWidget(
                widget: ValueListenableBuilder(
                    valueListenable: loading,
                    builder: (context, value, child) {
                      if (value) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.sp),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        return MyText(
                          text: 'Approve Request'.tr(),
                          size: 18.sp,
                          weight: FontWeight.w600,
                        );
                      }
                    }),
                color: loginBtnColor,
                onPressed: () {
                  if (hourController.text.isNotEmpty) {
                    if (int.parse(hourController.text) <= 48) {
                      loading.value = true;

                      context
                          .read<PayLaterRequestApproveCubit>()
                          .fetchPayLaterRequestApprove(
                              id, 1, hourController.text.trim());
                      hourController.clear();
                    } else {
                      flutterSnackBar(
                          context, 'hours must be less than 49 hours');
                      hourController.clear();
                    }
                  }
                }),
          )
        ],
        content: MyFormField(
            isRequired: false,
            hintText: 'Enter Between 1-48 hrs'.tr(),
            keyboardType: TextInputType.number,
            controller: hourController,
            label: 'Enter Pay Later Time (Max. 48hrs)'.tr()),
        titlePadding: EdgeInsets.zero,
        title: Container(
          height: 48.sp,
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          decoration: const BoxDecoration(
            color: lightGray,
          ),
          child: Row(
            children: [
              Expanded(
                child: MyText(
                  text: "Pay Later Approval".tr(),
                  size: 16.sp,
                  weight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: context.locale.languageCode == 'en'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child:
                          // Text("cancelSvg")
                          SvgPicture.asset(closeSvg),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  rejectDialog(BuildContext context, {id, orderId}) {
    return CustomConfirmationDialog(
      message: "This will reject the request from list",
      title: "Rejection Confirmation?",
      index: id,
      orderId: orderId,
      paymentMethod: "Pay Later",
      paymentRequest: 'payLaterRequestResponse',
      route: "signaturePayLater",
    );
  }
}
