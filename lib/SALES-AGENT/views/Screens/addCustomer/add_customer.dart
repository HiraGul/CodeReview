import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/addCustomerCubit/add_customer_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/allCustomerCubit/all_customer_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/cityListCubit/city_list_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/countryListCubit/country_list_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/customerCheckinCubit/customer_checkin_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/districtListCubit/district_list_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/message.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_text.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/rounded_btn_widget.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/success_card.dart';
import 'package:tojjar_delivery_app/commonWidgets/LoadingWidget.dart';

import '../../../../DELIVERY/Utils/strings.dart';
import '../../../controller/cubits/addCustomerCubit/add_customer_cubit.dart';
import '../../../controller/cubits/stateListCubit/state_list_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/determine_position.dart';
import '../../../utils/global_field_and_variable.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/dotted_box_widget.dart';
import 'components/add_customer_detail_component.dart';
import 'components/add_shop_detail_component.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  //google map controller
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // notifier for checkbox
  var carbonateDrink = ValueNotifier<bool>(false);
  var food = ValueNotifier<bool>(false);

  // form Key for validation
  final _formKey = GlobalKey<FormState>();

  //value notifier for location
  var location = ValueNotifier<Position>(const Position(
      longitude: 23.8859,
      latitude: 45.0792,
      timestamp: null,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0));

  var loading = ValueNotifier<bool>(false);

  //value on checkBox
  String? selectedValue;
  //get the current
  var locationLoading = ValueNotifier<bool>(true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CountryListCubit>().fetchCountryListData();
    context.read<DistrictListCubit>().fetchDistrictListData();
    context.read<CityListCubit>().fetchCityListData();
    context.read<StateListCubit>().fetchStateListData();
    getCurrentPosition();
  }

  getCurrentPosition() async {
    try {
      await determinePosition(location);
      locationLoading.value = false;
      locationLink =
          "https://www.google.com/maps?q=${location.value.latitude},${location.value.longitude}";
      // locationLink =
      //     'https://www.google.com/maps/search/?api=1&latlng=${location.value.latitude},${location.value.longitude}';
      myLatitude = location.value.latitude;
      myLongitude = location.value.longitude;
    } catch (e) {
      showMessage(context, e.toString());
      locationLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: CustomAppBar(
          onPressed: () {
            Navigator.pop(context);
          },
          parentContext: context,
          title: MyText(
            text: "Customer Details".tr(),
            size: 18.sp,
            color: loginBtnColor,
          ),
          titleColor: loginBtnColor,
          appBarColor: whiteColor,
          leadingSize: 27.sp,
          titleSize: 18.sp,
        ),
        body: ValueListenableBuilder(
            valueListenable: locationLoading,
            builder: (context, locationLoadingValue, child) {
              if (locationLoadingValue) {
                return Center(
                  child: loadingIndicator(),
                );
              } else {
                return ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          left: 15.sp, right: 15.sp, bottom: 50.sp, top: 18.sp),
                      children: [
                        const AddCustomerDetailComponent(),
                        28.ph,
                        AddShopDetailComponent(
                          location: location,
                          carbonateDrink: carbonateDrink,
                          food: food,
                        ),
                        23.ph,
                        DottedBoxWidget(
                          label: 'Attach CR'.tr(),
                          text: 'Drop CR Document here to upload'.tr(),
                          imagePath: (path) {
                            crImage = path;
                          },
                        ),
                        23.ph,
                        DottedBoxWidget(
                          label: 'Attach VAT Certificate'.tr(),
                          text: 'Drop VAT Document here to upload'.tr(),
                          imagePath: (path) {
                            certificateImage = path;
                          },
                        ),
                        23.ph,
                        DottedBoxWidget(
                          label: 'Attach Shop Picture'.tr(),
                          text: 'Drop Picture here to upload'.tr(),
                          imagePath: (path) {
                            shopImage = path;
                          },
                        ),
                        32.ph,
                        BlocListener<AddCustomerCubit, AddCustomerState>(
                          listener: (context, state) {
                            if (state is AddCustomerLoadedState) {
                              if (addCustomerModelController!.result == true) {
                                loading.value = !loading.value;

                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        content: SuccessCard(
                                            title:
                                                'Registration Successful'.tr(),
                                            description:
                                                'Customer Registered Successfully'
                                                    .tr()),
                                      );
                                    });
                                Timer(const Duration(seconds: 2), () {
                                  Navigator.popUntil(context,
                                      ModalRoute.withName(Strings.customers));
                                });
                                context
                                    .read<AllCustomerCubit>()
                                    .fetchAllCustomer();
                                context
                                    .read<CustomerCheckInCubit>()
                                    .fetchCustomerCheckInData();
                              } else {
                                showMessage(context,
                                    addCustomerModelController!.message);
                                loading.value = !loading.value;
                              }
                            }
                            if (state is AddCustomerErrorState) {
                              showMessage(context, state.error);
                              loading.value = !loading.value;
                            }
                            if (state is AddCustomerNoInternetState) {
                              showMessage(
                                  context, "No Internet Connection".tr());
                              loading.value = !loading.value;
                            }
                            if (state is AddCustomerInvalidParameter) {
                              showMessage(context,
                                  addCustomerErrorModelController!.errors![0]);
                              loading.value = !loading.value;
                            }
                            if (state is AddCustomerBadRequest) {
                              showMessage(context, "invalid request".tr());
                              loading.value = !loading.value;
                            }
                          },
                          child: RoundedBtnWidget(
                              widget: ValueListenableBuilder(
                                  valueListenable: loading,
                                  builder: (context, value, child) {
                                    if (value) {
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.sp,
                                              horizontal: 10.sp),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 4.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return MyText(
                                        text: "Register".tr(),
                                        size: 18.sp,
                                        weight: FontWeight.w600,
                                      );
                                    }
                                  }),
                              color: loginBtnColor,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  loading.value = !loading.value;
                                  await context
                                      .read<AddCustomerCubit>()
                                      .addCustomer();
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
