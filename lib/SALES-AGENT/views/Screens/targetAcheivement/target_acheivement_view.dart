import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/targetAndAchievementCubit/target_achievement_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/targetAcheivement/components/row_component.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/rounded_btn_widget.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';

import '../../../../commonWidgets/empty_state.dart';
import '../../../../commonWidgets/no_internet.dart';
import '../../../controller/cubits/targetAndAchievementCubit/target_achievement_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/my_text.dart';

class TargetAcheivementView extends StatefulWidget {
  const TargetAcheivementView({super.key});

  @override
  State<TargetAcheivementView> createState() => _TargetAcheivementViewState();
}

class _TargetAcheivementViewState extends State<TargetAcheivementView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TargetAchievementCubit>().fetchTargetAchievementData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        parentContext: context,
        leadingSize: 25.sp,
        title: MyText(
          text: "My Targets and Achievements".tr(),
          size: 16.sp,
          color: appBarTitleColor,
        ),
        titleColor: appBarTitleColor,
        titleSize: 16.sp,
        titleWeight: FontWeight.w600,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 26.sp, left: 16.sp, right: 16.sp),
        shrinkWrap: true,
        children: [
          MyText(
            textAlign: TextAlign.center,
            text: 'My Targets and Achievements'.tr(),
            size: 21.sp,
            weight: FontWeight.w500,
            color: Colors.black,
          ),
          25.ph,
          Container(
            padding: EdgeInsets.only(
                top: 20.sp,
                left: 35.sp,
                right: 44.sp,
                bottom: context.locale.languageCode == 'en' ? 38.sp : 15.sp),
            height: 470.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.sp),
              color: Colors.white,
              border: Border.all(
                color: borderColor,
                width: 1.sp,
              ),
            ),
            child: BlocBuilder<TargetAchievementCubit, TargetAchievementState>(
              builder: (context, state) {
                if (state is TargetAchievementLoadingState) {
                  return Center(
                    child: loadingIndicator(),
                  );
                }
                if (state is TargetAchievementLoadedState) {
                  return Column(
                    children: [
                      MyText(
                        text: 'Monthly Summary'.tr(),
                        size: 18.sp,
                        weight: FontWeight.w400,
                        color: greenColor,
                      ),
                      27.ph,
                      const Divider(),
                      10.ph,
                      RowComponent(
                          dataKey: 'Total Delivered',
                          data: targetAndAchievementsModelController!
                              .data!.totalDelivered
                              .toString()),
                      13.ph,
                      RowComponent(
                          dataKey: 'Total Sales (SAR)',
                          data: targetAndAchievementsModelController!
                              .data!.totalEarnings
                              .toString()),
                      15.ph,
                      RowComponent(
                          dataKey: 'Rescheduled',
                          data: targetAndAchievementsModelController!
                              .data!.totalRescheduled
                              .toString()),
                      15.ph,
                      RowComponent(
                          dataKey: 'On-Hold',
                          data: targetAndAchievementsModelController!
                              .data!.totalOnHold
                              .toString()),
                      15.ph,
                      RowComponent(
                          dataKey: 'Revisit',
                          data: targetAndAchievementsModelController!
                              .data!.totalRevisited
                              .toString()),
                      15.ph,
                      RowComponent(
                          dataKey: 'Cancel',
                          data: targetAndAchievementsModelController!
                              .data!.totalCancel
                              .toString()),
                      40.ph,
                      const Divider(),
                      27.ph,
                      RoundedBtnWidget(
                          widget: MyText(
                            text: "Back To Dashboard".tr(),
                            size: 16.sp,
                            weight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          color: loginBtnColor,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  );
                }
                if (state is TargetAchievementNoDataState) {
                  return const Center(
                    child: EmptyData(),
                  );
                }
                if (state is TargetAchievementNoInternetState) {
                  return Center(
                    child: NoInternetWidget(onTap: () {
                      context
                          .read<TargetAchievementCubit>()
                          .fetchTargetAchievementData();
                    }),
                  );
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
