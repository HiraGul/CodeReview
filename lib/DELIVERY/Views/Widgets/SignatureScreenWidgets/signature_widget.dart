// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/SIgnatureHideCubit/signature_hide.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

class SignatureSection extends StatelessWidget {
  SignatureController signatureController;

  SignatureSection({required this.signatureController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignatureHideCubit, bool>(
      builder: (context, state) {
        return state
            ? Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                        child: Text(
                          "Customer Signature".tr(),
                          style: GoogleFonts.openSans(
                            fontSize: 16.0.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 6,

                    /// E-Signature
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ClipRRect(
                                child: SizedBox(
                                  height: 0.5.sh,
                                  child: Signature(
                                    width: 0.9.sw,
                                    height: 0.5.sh,
                                    controller: signatureController,
                                    backgroundColor: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  signatureController.clear();
                                },
                                child: const Icon(Icons.refresh),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            /// onTap method for Skip Signature
                            onTap: () {
                              BlocProvider.of<SignatureHideCubit>(context)
                                  .signatureHide(
                                signature: false,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Skip'.tr(),
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22.sp,
                                      color: AppColors.dullPrimary),
                                ),
                                Icon(
                                  Icons.keyboard_double_arrow_right_rounded,
                                  size: 26.sp,
                                  color: AppColors.dullPrimary,
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
