import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/check_box_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/partial_payment_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/pay_later_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SignatureScreen/signature_partial_pay.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SignatureScreen/signature_pay_later.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_button.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/Diloges/not_delivered_dilog.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/Diloges/on_hold.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/Diloges/reshedule_order.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/InvoiceDetailsWidgets/Diloges/revisit.dart';
import 'package:tojjar_delivery_app/commonWidgets/FlutterToast.dart';

class InvoiceDetailsButtonWidget extends StatelessWidget {
  const InvoiceDetailsButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 240.sp,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.kDisableButtonColor,
            offset: Offset(
              5.0.sp,
              5.0.sp,
            ),
            blurRadius: 10.0.sp,
            spreadRadius: 2.0.sp,
          ), //BoxShadow
        ],
        borderRadius: BorderRadius.circular(4.0.r),
        color: Colors.white,
        border: Border.all(width: 1.0, color: AppColors.kDisableButtonColor),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 10.sp,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    isIcon: Images.cancel,
                    iconData: Icon(
                      Icons.close,
                      size: 15.sp,
                      color: AppColors.brightRedColor,
                    ),
                    iconCheck: 2,
                    height: 52.sp,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return const NotDeliveredDialog();
                          });
                    },
                    title: 'Not Delivered'.tr(),
                    buttonColor: AppColors.brightRedColor,
                    textColor: AppColors.whiteColor,
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                  child: CustomButton(
                    iconData: Icon(
                      Icons.pause,
                      size: 15.sp,
                      color: AppColors.orangeColor,
                    ),
                    iconCheck: 2,
                    height: 52.sp,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return const OnHoldDialog();
                          });
                    },
                    title: 'On Hold'.tr(),
                    buttonColor: AppColors.orangeColor,
                    textColor: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.sp,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    iconCheck: 1,
                    isIcon: Images.rescheduled,
                    height: 52.sp,
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext bc) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: const RescheduledDialog(),
                            );
                          });
                    },
                    title: 'Rescheduled'.tr(),
                    buttonColor: AppColors.primaryColor,
                    textColor: AppColors.whiteColor,
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                  child: CustomButton(
                    iconData: Icon(
                      Icons.loop,
                      size: 15.sp,
                      color: AppColors.dullPrimary,
                    ),
                    iconCheck: 2,
                    height: 52.sp,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return const RevisitDialog();
                          });
                    },
                    title: 'Revisit'.tr(),
                    buttonColor: AppColors.dullPrimary,
                    textColor: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 13.sp),
            child: BlocBuilder<SelectSingleProductCubit, List<bool>>(
              builder: (context, state) {
                return CustomButton(
                  iconCheck: 3,
                  height: 52.sp,
                  onTap: () {
                    if (state.contains(true)) {
                      if (PayLaterRepo.payLetterStatus != 'null' &&
                          PayLaterRepo.payLetterStatus != -1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ESignaturePayLaterScreen(
                                      orderId: OrderDetailsController
                                          .orderDetailModel.data.id
                                          .toString(),
                                    )));
                      } else if (PartialPaymentRepo.partialStatus != 'null' &&
                          PartialPaymentRepo.partialStatus != -1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignaturePartialPay(
                                    orderId: OrderDetailsController
                                        .orderDetailModel.data.id
                                        .toString())));
                      } else {
                        Navigator.pushNamed(context, Strings.signatureScreen);
                      }
                    } else {
                      flutterSnackBar(context,
                          'Please select atleast one item to continue'.tr());
                    }
                  },
                  title: 'Delivered'.tr(),
                  buttonColor: AppColors.greenColor,
                  textColor: AppColors.whiteColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
