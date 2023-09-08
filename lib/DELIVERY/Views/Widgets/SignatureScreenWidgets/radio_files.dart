import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CheckPartialPayRequest/check_partial_pay_request_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CheckPayLaterCubit/check_pay_later_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/partial_payment_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/pay_later_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/enums.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/SignatureScreenWidgets/Dialog/partial_pay_dialog.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/SignatureScreenWidgets/Dialog/pay_later_request_dialog.dart';

class SplashScreenRadioButtons extends StatefulWidget {
  final ValueNotifier disableDeliveredButton;
  final TextEditingController paymentMethod;

  const SplashScreenRadioButtons({Key? key,required this.disableDeliveredButton, required this.paymentMethod})
      : super(key: key);

  @override
  State<SplashScreenRadioButtons> createState() =>
      _SplashScreenRadioButtonsState();
}

class _SplashScreenRadioButtonsState extends State<SplashScreenRadioButtons> {
  PaymentMethod _site = PaymentMethod.cash_on_delivery;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 45.sp,
          child: ListTile(
            minVerticalPadding: 0.sp,
            title: Text(
              "Cash on Delivery".tr(),
              style: GoogleFonts.openSans(
                fontSize: 16.0.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Radio(
              fillColor: MaterialStateProperty.all<Color>(
                AppColors.primaryColor,
              ),
              activeColor: AppColors.primaryColor,
              value: PaymentMethod.cash_on_delivery,
              groupValue: _site,
              onChanged: (PaymentMethod? value) {
                widget.paymentMethod.text = 'cash_on_delivery';

                widget.disableDeliveredButton.value = false;
                setState(() {
                  _site = value!;
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: 45.sp,
          child: ListTile(
            minVerticalPadding: 0.sp,
            title: Text(
              "Card Payment".tr(),
              style: GoogleFonts.openSans(
                fontSize: 16.0.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Radio(
              fillColor: MaterialStateProperty.all<Color>(
                AppColors.primaryColor,
              ),
              activeColor: AppColors.primaryColor,
              value: PaymentMethod.pay2,
              groupValue: _site,
              onChanged: (PaymentMethod? value) {
                widget.paymentMethod.text = 'card_payment';
                widget.disableDeliveredButton.value = false;

                setState(() {
                  _site = value!;
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: 45.sp,
          child: ListTile(
            title: Text(
              "Bank Transfer".tr(),
              style: GoogleFonts.openSans(
                fontSize: 16.0.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Radio(
              fillColor: MaterialStateProperty.all<Color>(
                AppColors.primaryColor,
              ),
              activeColor: AppColors.primaryColor,
              value: PaymentMethod.pay3,
              groupValue: _site,
              onChanged: (PaymentMethod? value) {
                widget.paymentMethod.text = 'bank_transfer';
                widget.disableDeliveredButton.value = false;

                setState(() {
                  _site = value!;
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: 45.sp,
          child: ListTile(
            title: Text(
              "Pay Later".tr(),
              style: GoogleFonts.openSans(
                fontSize: 16.0.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Radio(
              fillColor: MaterialStateProperty.all<Color>(
                AppColors.primaryColor,
              ),
              activeColor: AppColors.primaryColor,
              value: PaymentMethod.pay4,
              groupValue: _site,
              onChanged: (PaymentMethod? value) {
                widget.paymentMethod.text = 'pay_later';
                widget.disableDeliveredButton.value = true;

                setState(() {
                  _site = value!;
                });
              },
            ),
          ),
        ),
        _site == PaymentMethod.pay4
            ? BlocBuilder<CheckPayLaterCubit, CheckPayLaterState>(
                builder: (context, state) {
                  return PayLaterRepo.payLetterStatus == -1
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100.sp),
                          child: Text(
                            "Request Rejected".tr(),
                            style: GoogleFonts.openSans(
                              fontSize: 16.0.sp,
                              color: AppColors.redColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 5.sp),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return const PayLaterRequestDialog();
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 80.sp,
                                ),
                                width: 140.sp,
                                height: 30.sp,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: AppColors.primaryColor,
                                )),
                                child: Center(
                                  child: Text(
                                    "Send Request".tr(),
                                    style: GoogleFonts.openSans(
                                      fontSize: 14.0.sp,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                },
              )
            : const SizedBox(),
        SizedBox(
          height: 45.sp,
          child: ListTile(
            title: Text(
              "Partial Payment".tr(),
              style: GoogleFonts.openSans(
                fontSize: 16.0.sp,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Radio(
              fillColor: MaterialStateProperty.all<Color>(
                AppColors.primaryColor,
              ),
              activeColor: AppColors.primaryColor,
              value: PaymentMethod.pay5,
              groupValue: _site,
              onChanged: (PaymentMethod? value) {
                widget.paymentMethod.text = 'partial_pay';
                widget.disableDeliveredButton.value = true;

                setState(() {
                  _site = value!;
                });
              },
            ),
          ),
        ),
        _site == PaymentMethod.pay5
            ? BlocBuilder<CheckPartialPayRequestCubit,
                CheckPartialPayRequestState>(
                builder: (context, state) {
                  return PartialPaymentRepo.partialStatus == -1
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100.sp),
                          child: Text(
                            "Request Rejected".tr(),
                            style: GoogleFonts.openSans(
                              fontSize: 16.0.sp,
                              color: AppColors.redColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 5.sp),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return const PartialPaymentDialog();
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 80.sp,
                                ),
                                width: 140.sp,
                                height: 30.sp,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: AppColors.primaryColor,
                                )),
                                child: Center(
                                  child: Text(
                                    "Send Request".tr(),
                                    style: GoogleFonts.openSans(
                                      fontSize: 14.0.sp,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                },
              )
            : const SizedBox(),
        SizedBox(
          height: 777.sp,
        )
      ],
    );
  }
}
