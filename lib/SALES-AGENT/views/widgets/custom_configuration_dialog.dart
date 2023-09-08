import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPaymentRejectCubit/partial_payment_reject_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPaymentRejectCubit/partial_payment_reject_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPendingRequestCubit/partial_pending_request_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/payLaterRequestRejectCubit/pay_later_request_reject_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/payLaterRequestRejectCubit/pay_later_request_reject_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/pendingRequestCubit/pending_request_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/fcm_repo.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_text.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/round_container_btn.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/rounded_btn_widget.dart';

import '../../../DELIVERY/Utils/colors.dart';
import '../../../DELIVERY/Utils/strings.dart';

class CustomConfirmationDialog extends StatefulWidget {
  final String title;
  final String message;
  final int? index;
  final String paymentMethod;
  final String paymentRequest;
  final String route;
  final int orderId;

  const CustomConfirmationDialog(
      {Key? key,
      required this.title,
      required this.message,
      this.index,
      required this.paymentMethod,
      required this.paymentRequest,
      required this.route,
      required this.orderId})
      : super(key: key);

  @override
  State<CustomConfirmationDialog> createState() =>
      _CustomConfirmationDialogState();
}

class _CustomConfirmationDialogState extends State<CustomConfirmationDialog> {
  var isLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 34.sp,
          ),
          SizedBox(
              height: 57.sp,
              child: Image.asset(
                'assets/images/delete.jpg',
              )),
          SizedBox(
            height: 17.sp,
          ),
          Text(
            widget.title.tr(),
            style: GoogleFonts.openSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.redColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 4.sp,
          ),
          Text(
            widget.message.tr(),
            style: GoogleFonts.openSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.greyColor,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 24.sp),
            child: Row(
              children: [
                Expanded(
                  child: RoundContainerBtn(
                      textColor: AppColors.blackColor,
                      borderColor: AppColors.blackColor,
                      text: "Cancel".tr(),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                  child: Container(
                    width: 1.sw,
                    height: 48.sp,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(24.r),
                      border:
                          Border.all(color: AppColors.lightWhite, width: 1.sp),
                    ),
                    child: widget.paymentMethod == "Partial Payment"
                        ? BlocListener<PartialPaymentRejectCubit,
                            PartialPaymentRejectState>(
                            listener: (context, state) async {
                              if (state is PartialPaymentRejectLoadedState) {
                                // Navigator.pushNamed(context, Strings.payLaterRequest);
                                await FcmRepo().sendNotification(
                                    widget.index,
                                    widget.orderId,
                                    widget.paymentRequest,
                                    "${widget.paymentMethod} Request rejected"
                                        .tr(),
                                    "Your Request for ${widget.paymentMethod} has been rejected"
                                        .tr(),
                                    widget.route);

                                isLoading.value = !isLoading.value;
                                if (context.mounted) {
                                  context
                                      .read<PartialPendingRequestCubit>()
                                      .fetchPendingRequest();
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          Strings.partialPayRequest));
                                }
                              }
                            },
                            child: RoundedBtnWidget(
                              onPressed: () {
                                isLoading.value = true;
                                context
                                    .read<PartialPaymentRejectCubit>()
                                    .fetchPartialPaymentReject(widget.index);
                              },
                              color: loginBtnColor,
                              widget: ValueListenableBuilder(
                                  valueListenable: isLoading,
                                  builder: (context, value, child) {
                                    if (value) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.sp),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return MyText(
                                        text: "Confirm".tr(),
                                        size: 16.sp,
                                      );
                                    }
                                  }),
                            ),
                          )
                        : BlocListener<PayLaterRequestRejectCubit,
                            PayLaterRequestRejectState>(
                            listener: (context, state) async {
                              if (state is PayLaterRequestRejectLoadedState) {
                                // Navigator.pushNamed(context, Strings.payLaterRequest);
                                await FcmRepo().sendNotification(
                                    widget.index,
                                    widget.orderId,
                                    widget.paymentRequest,
                                    "${widget.paymentMethod} Request rejected",
                                    "Your Request for ${widget.paymentMethod} has been rejected",
                                    widget.route);

                                isLoading.value = !isLoading.value;
                                if (context.mounted) {
                                  context
                                      .read<PendingRequestCubit>()
                                      .fetchPendingRequest();
                                  Navigator.popUntil(
                                      context,
                                      ModalRoute.withName(
                                          Strings.payLaterRequest));
                                }
                              }
                            },
                            child: RoundedBtnWidget(
                              onPressed: () {
                                isLoading.value = true;
                                context
                                    .read<PayLaterRequestRejectCubit>()
                                    .fetchPayLaterRequestReject(widget.index);
                              },
                              color: loginBtnColor,
                              widget: ValueListenableBuilder(
                                  valueListenable: isLoading,
                                  builder: (context, value, child) {
                                    if (value) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.sp),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return MyText(
                                        text: 'Confirm'.tr(),
                                        size: 16.sp,
                                      );
                                    }
                                  }),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
        ],
      ),
    );
  }
}
