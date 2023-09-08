import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/countryListCubit/country_list_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/countryListCubit/country_list_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/stateListCubit/state_list_cubit.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/data/dataController/data_controller.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/determine_position.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/Screens/addCustomer/components/custom_drop_down_button.dart';

import '../../../../controller/cubits/cityListCubit/city_list_cubit.dart';
import '../../../../controller/cubits/cityListCubit/city_list_state.dart';
import '../../../../controller/cubits/districtListCubit/district_list_cubit.dart';
import '../../../../controller/cubits/districtListCubit/district_list_state.dart';
import '../../../../controller/cubits/shopType/shop_type_cubit.dart';
import '../../../../controller/cubits/stateListCubit/state_list_state.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/global_field_and_variable.dart';
import '../../../widgets/my_form_field.dart';
import '../../../widgets/my_text.dart';
import '../../../widgets/required_field_label.dart';

class AddShopDetailComponent extends StatefulWidget {
  const AddShopDetailComponent(
      {super.key,
      // required this.shopNameController,
      // required this.shopAddressController,
      // required this.postalCodeController,
      required this.carbonateDrink,
      required this.food,
      required this.location});

  // final TextEditingController shopNameController;
  // final TextEditingController shopAddressController;
  // final TextEditingController postalCodeController;
  final ValueNotifier carbonateDrink, food;
  final ValueNotifier<Position> location;

  @override
  State<AddShopDetailComponent> createState() => _AddShopDetailComponentState();
}

class _AddShopDetailComponentState extends State<AddShopDetailComponent> {
  GoogleMapController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: "Shop Details".tr(),
          size: 18.sp,
          weight: FontWeight.bold,
          color: loginBtnColor,
        ),
        22.ph,
        MyFormField(
            isRequired: true,
            controller: shopNameController,
            label: "Shop Name".tr(),
            keyboardType: TextInputType.name),

        22.ph,
        RequiredFieldLabel(title: "Google Map Location".tr()),
        6.ph,
        SizedBox(
            height: 225.sp,
            child: ValueListenableBuilder(
                valueListenable: widget.location,
                builder: (context, locationValue, child) {
                  return GoogleMap(
                    onMapCreated: (controller) {
                      _controller = controller;
                      setState(() {});
                    },
                    mapType: MapType.normal,
                    rotateGesturesEnabled: true,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    buildingsEnabled: true,
                    trafficEnabled: true,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    // compassEnabled: true,
                    markers: {
                      Marker(
                          icon: BitmapDescriptor.defaultMarker,
                          markerId: MarkerId(
                              widget.location.value.latitude.toString()),
                          draggable: true,
                          position: LatLng(
                              locationValue.latitude, locationValue.longitude),
                          onDragEnd: (newLocation) {
                            myLatitude = newLocation.latitude;
                            myLongitude = newLocation.longitude;

                            locationLink =
                                "https://www.google.com/maps?q=${newLocation.latitude},${newLocation.longitude}";

                            // locationLink =
                            //     'https://www.google.com/maps/place/?api=1&latlng=${newLocation.latitude},${newLocation.longitude}';
                          })
                    },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                          locationValue.latitude,
                          locationValue.longitude,
                        ),
                        zoom: 8),
                  );
                })),
        16.ph,
        InkWell(
          onTap: () {
            _controller!.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    zoom: 15,
                    target: LatLng(widget.location.value.latitude,
                        widget.location.value.longitude))));
            determinePosition(widget.location);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.location_pin,
                color: loginBtnColor,
                size: 20.sp,
              ),
              5.pw,
              MyText(
                text: "Locate me".tr(),
                size: 14.sp,
                color: const Color(0xff013861),
              )
            ],
          ),
        ),
        22.ph,
        MyFormField(
            controller: shopAddressController,
            label: "Shop Address".tr(),
            maxLine: 5,
            keyboardType: TextInputType.streetAddress),
        22.ph,
        RequiredFieldLabel(title: "District Name".tr()),
        6.ph,
        //country list implementation remain
        BlocBuilder<DistrictListCubit, DistrictListState>(
          builder: (context, state) {
            if (state is DistrictListLoadedState) {
              return CustomDropDownButton(
                  dropDownItems: districtListModelController!.data!,
                  onChange: (district, id) {
                    // districtName = district;
                    districtId = id;
                  },
                  hint: '');
            }
            return const SizedBox();
          },
        ),
        22.ph,
        RequiredFieldLabel(title: "Country".tr()),
        6.ph,
        BlocBuilder<CountryListCubit, CountryListState>(
          builder: (context, state) {
            if (state is CountryListLoadedState) {
              return CustomDropDownButton(
                  dropDownItems: countryListModelController!.data!,
                  onChange: (cntry, id) {
                    countryId = id!;
                  },
                  hint: '');
            }
            return const SizedBox();
          },
        ),
        22.ph,
        RequiredFieldLabel(title: "City".tr()),
        6.ph,
        BlocBuilder<CityListCubit, CityListState>(
          builder: (context, state) {
            if (state is CityListLoadedState) {
              return CustomDropDownButton(
                  dropDownItems: cityListModelController!.data!,
                  onChange: (district, id) {
                    cityId = id;
                  },
                  hint: '');
            }
            return const SizedBox();
          },
        ),

        // Row(
        //   children: [
        //     Expanded(
        //         child: Column(
        //       children: [

        //         // MyDropDownButton(
        //         //     items: const ["Pakistan", "Saudi", "UAE"],
        //         //     onChange: (value) {}),
        //       ],
        //     )),

        //     Expanded(
        //         child: Column(
        //       children: [

        //         // MyDropDownButton(
        //         //     items: const ['Islamabad', "Sharjha", "Riyyadh"],
        //         //     onChange: (value) {}),
        //       ],
        //     ))
        //   ],
        // ),
        22.ph,
        RequiredFieldLabel(title: "State".tr()),
        6.ph,
        BlocBuilder<StateListCubit, StateListState>(
          builder: (context, state) {
            if (state is StateListLoadedState) {
              return CustomDropDownButton(
                  dropDownItems: cityListModelController!.data!,
                  onChange: (district, id) {
                    stateId = id;
                  },
                  hint: '');
            }
            return const SizedBox();
          },
        ),
        22.ph,
        RequiredFieldLabel(title: "Shop Type".tr()),
        6.ph,
        CustomDropDownButton(
            hint: "Select shop Type".tr(),
            dropDownItems: [
              'Super Market'.tr(),
              "Restaurant".tr(),
              "Semi-wholesaler".tr(),
              'Boofia'.tr(),
              'Coffee Shop'.tr(),
              "Others".tr()
            ],
            onChange: (value, id) {
              context.read<ShopTypeCubit>().changeShop(value);
              shopType = value;
            }),
        22.ph,
        BlocBuilder<ShopTypeCubit, String>(builder: (context, state) {
          if (state == 'Super Market' || state == 'سوبر ماركت') {
            return Column(
              children: [
                RequiredFieldLabel(title: "Super Market Category".tr()),
                6.ph,
                CustomDropDownButton(
                    hint: 'Select super market category'.tr(),
                    dropDownItems: const ['Cat A', "Cat B", "Cat C"],
                    onChange: (value, id) {
                      shopCategory.clear();
                      shopCategory.add(value!);
                    }),
              ],
            );
          }
          if (state == 'Restaurant' || state == "مطعم") {
            return Column(
              children: [
                RequiredFieldLabel(title: "Restaurant Type".tr()),
                6.ph,
                CustomDropDownButton(
                    hint: "Select restaurant type".tr(),
                    dropDownItems: const ['Fast Food', "Traditional", "Chain"],
                    onChange: (value, id) {
                      shopCategory.clear();
                      shopCategory.add(value!);
                    }),
              ],
            );
          }
          if (state == 'Semi-wholesaler' || state == "تاجر شبه جملة") {
            return Row(
              children: [
                Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: widget.carbonateDrink,
                        builder: (context, value, child) {
                          return CheckboxListTile(
                              checkboxShape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                color: checkBoxBorderColor,
                                width: 0,
                              )),
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: MyText(
                                  text: 'Carbonated drinks'.tr(), size: 14.sp),
                              value: value,
                              onChanged: (value) {
                                widget.carbonateDrink.value =
                                    !widget.carbonateDrink.value;
                                if (widget.carbonateDrink.value) {
                                  if (!(shopCategory
                                      .contains('Carbonated drinks'))) {
                                    shopCategory.add("Carbonated drinks");
                                  }
                                }
                              });
                        })),
                Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: widget.food,
                        builder: (context, value, child) {
                          return CheckboxListTile(
                              checkboxShape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                color: checkBoxBorderColor,
                                width: 0,
                              )),
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              title: MyText(text: 'Food'.tr(), size: 14.sp),
                              value: value,
                              onChanged: (value) {
                                widget.food.value = !widget.food.value;
                                if (widget.food.value) {
                                  if (!(shopCategory.contains('Food'))) {
                                    shopCategory.add("Food");
                                  }
                                }
                              });
                        }))
              ],
            );
          }
          // if (state == 'Boofia') {
          //   return Column(
          //     children: [
          //       RequiredFieldLabel(title: "Boofia Category".tr()),
          //       6.ph,
          //       MyDropDownButton(
          //           hint: 'Select Boofia Category'.tr(),
          //           items: const ['A', "B", "C"],
          //           onChange: (value) {}),
          //     ],
          //   );
          // }
          // if (state == 'Coffee Shop') {
          //   return Column(
          //     children: [
          //       RequiredFieldLabel(title: "Coffee Shop Category".tr()),
          //       6.ph,
          //       MyDropDownButton(
          //           hint: 'Select Coffee Shop Category'.tr(),
          //           items: const ['A', "B", "C"],
          //           onChange: (value) {}),
          //     ],
          //   );
          // }
          // if (state == 'other Shop') {
          //   return Column(
          //     children: [
          //       RequiredFieldLabel(title: "other Shop Category".tr()),
          //       6.ph,
          //       MyDropDownButton(
          //           hint: 'Select Other Category'.tr(),
          //           items: const ['A', "B", "C"],
          //           onChange: (value) {}),
          //     ],
          //   );
          // }
          return const SizedBox(
            height: 0,
            width: 0,
          );
        })
      ],
    );
  }
}
