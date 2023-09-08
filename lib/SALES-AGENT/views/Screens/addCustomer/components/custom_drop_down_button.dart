import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/app_colors.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/spacing.dart';

import '../../../widgets/my_text.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton(
      {super.key,
      required this.dropDownItems,
      required this.onChange,
      required this.hint});

  final List<dynamic> dropDownItems;
  final Function(String?, int?) onChange;
  final String hint;

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? _selectedItem;
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isDropdownOpen = !_isDropdownOpen;
            });
          },
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
              left: 20.sp,
              right: context.locale.languageCode == 'en' ? 5.sp : 20.sp,
            ),
            height: 45.sp,
            decoration: BoxDecoration(
                border: Border.all(color: fieldBorderColor),
                borderRadius: BorderRadius.circular(2.sp)),
            child: Row(
              children: [
                Expanded(
                  child: MyText(
                    text: _selectedItem == null ? widget.hint : _selectedItem!,
                    size: 14.sp,
                    color: fieldHintColor,
                  ),
                  // Text(
                  //     _selectedItem == null ? 'select an item' : _selectedItem!),
                ),
                Expanded(
                    child: Align(
                  alignment: context.locale.languageCode == 'en'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Icon(
                      color: loginBtnColor,
                      size: 20.sp,
                      _isDropdownOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                ))
              ],
            ),
          ),
        ),
        3.ph,
        if (_isDropdownOpen)
          Container(
            alignment: Alignment.centerLeft,
            // width: double.infinity,
            padding: EdgeInsets.only(
                top: 15.sp,
                left: 20.sp,
                right: context.locale.languageCode == 'en' ? 0.sp : 20.sp),
            decoration: BoxDecoration(
                border: Border.all(color: fieldBorderColor),
                borderRadius: BorderRadius.circular(2.sp)),
            child: Column(
              crossAxisAlignment: context.locale.languageCode == 'en'
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: widget.dropDownItems.map((item) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedItem =
                          item.runtimeType == String ? item : item.name;

                      widget.onChange(
                          item.runtimeType == String ? item : item.name,
                          item.runtimeType == String ? null : item.id);
                      _isDropdownOpen = false;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: context.locale.languageCode == 'en'
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MyText(
                              textAlign: context.locale.languageCode == 'en'
                                  ? TextAlign.start
                                  : TextAlign.end,
                              text: item.runtimeType == String
                                  ? item
                                  : item.name!,
                              size: 14.sp,
                              color: textDarkColor,
                            ),
                          ),
                        ],
                      ),
                      10.ph,
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
