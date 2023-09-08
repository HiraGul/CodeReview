import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/customerDetailCubit/customer_detail_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/customerDetailCubit/customer_detail_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/loginAsCustomerCubit/login_as_customer1_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/loginAsCustomerCubit/login_as_customer1_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/images_url.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/message.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/singleCustomer/components/customer_detail_component.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../DELIVERY/Utils/dynamic_link.dart';
import '../../../../DELIVERY/Utils/strings.dart';
import '../../../../commonWidgets/empty_state.dart';
import '../../../../commonWidgets/no_internet.dart';
import '../../../data/dataController/data_controller.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/my_text.dart';
import '../../widgets/rounded_btn_widget.dart';

class SingleCustomerDetail extends StatefulWidget {
  const SingleCustomerDetail({super.key});

  @override
  State<SingleCustomerDetail> createState() => _SingleCustomerDetailState();
}

class _SingleCustomerDetailState extends State<SingleCustomerDetail> {
  var id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //get the arguments which is send in name routing
    id = ModalRoute.of(context)?.settings.arguments as int;

    context.read<CustomerDetailCubit>().fetchCustomerDetailData(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        parentContext: context,
        leadingSize: 25.sp,
        titleWeight: FontWeight.w600,
        title: MyText(
          text: "Customer Details".tr(),
          size: 16.sp,
          color: appBarTitleColor,
        ),
        titleColor: appBarTitleColor,
        titleSize: 16.sp,
        action: [
          Container(
            height: 36.sp,
            padding: EdgeInsets.only(
                top: 15.sp,
                right: 15.sp,
                left: context.locale.languageCode == 'en' ? 0.sp : 15.sp),
            width: 175.sp,
            child: RoundedBtnWidget(
                textSize: 16.sp,
                widget: MyText(
                  text: "Add Customer".tr(),
                  size: 16.sp,
                  weight: FontWeight.w600,
                  color: Colors.white,
                ),
                color: loginBtnColor,
                textWeight: FontWeight.w600,
                onPressed: () {
                  Navigator.pushNamed(context, Strings.addCustomer);
                }),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 15.sp),
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 17.sp, right: 57.sp, top: 17.sp, bottom: 30.sp),
            decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: loginBtnColor, width: 0.1.sp)),
            child: BlocBuilder<CustomerDetailCubit, CustomerDetailState>(
              builder: (context, state) {
                if (state is CustomerDetailLoadingState) {
                  return Center(
                    child: loadingIndicator(),
                  );
                }
                if (state is CustomerDetailLoadedState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: context.locale.languageCode == 'en'
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: MyText(
                          text: "Customer Details".tr(),
                          color: textMediumColor,
                          size: 16.sp,
                          weight: FontWeight.bold,
                        ),
                      ),
                      15.ph,
                      const CustomerDetailComponent(),
                      28.ph,
                      GestureDetector(
                        onTap: () async {
                          context
                              .read<LoginAsCustomer1Cubit>()
                              .fetchLoginAsCustomer1(
                                  customerDetailModelController?.customer?.id);
                        },
                        child: BlocListener<LoginAsCustomer1Cubit,
                            LoginAsCustomer1State>(
                          listener: (context, state) async {
                            if (state is LoginAsCustomer1LoadingState) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: loadingIndicator(),
                                    );
                                  });
                            }
                            if (state is LoginAsCustomer1LoadedState) {
                              var encodeData =
                                  jsonEncode(loginCustomerController);
                              var url =
                                  await DynamicLink.createLink(encodeData);
                              debugPrint(url);
                              await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication);
                              Navigator.pop(context);
                            }
                            if (state is LoginAsCustomer1NoUserState) {
                              Navigator.pop(context);
                              showMessage(context, "no user found");
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                text: "Login As This User".tr(),
                                size: 18.sp,
                                color: yellowDark,
                              ),
                              4.pw,
                              // SvgPicture.asset(signInSvg)
                              SvgPicture.asset(signInSvg)
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                if (state is CustomerDetailNoDataState) {
                  return Center(
                    child: MyText(text: "No Data Available", size: 25.sp),
                  );
                }
                if (state is CustomerDetailNoDataState) {
                  return const Center(
                    child: EmptyData(),
                  );
                }
                if (state is CustomerDetailNoInternetState) {
                  return Center(
                    child: NoInternetWidget(onTap: () {
                      id = ModalRoute.of(context)?.settings.arguments as int;

                      context
                          .read<CustomerDetailCubit>()
                          .fetchCustomerDetailData(id);
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
