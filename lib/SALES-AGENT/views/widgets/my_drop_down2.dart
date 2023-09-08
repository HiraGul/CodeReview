import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import 'my_text.dart';

class MyDropDown2 extends StatefulWidget {
  const MyDropDown2(
      {super.key,
      required this.items,
      required this.onChange,
      this.selectedIndex,
      this.hint});
  final List<String> items;
  final Function(String?) onChange;
  final int? selectedIndex;
  final String? hint;

  @override
  State<MyDropDown2> createState() => _MyDropDown2State();
}

class _MyDropDown2State extends State<MyDropDown2> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: widget.hint == null
            ? const Text('')
            : MyText(text: widget.hint!, size: 14.sp),
        alignment: Alignment.bottomCenter,
        dropdownStyleData: DropdownStyleData(
            offset: const Offset(0, -2),
            decoration:
                BoxDecoration(border: Border.all(color: fieldBorderColor))),
        buttonStyleData: ButtonStyleData(
            height: 50.sp,
            decoration:
                BoxDecoration(border: Border.all(color: fieldBorderColor))),
        iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down),
            openMenuIcon: Icon(Icons.keyboard_arrow_up)),
        value: selectedItem,
        onChanged: (value) {
          setState(() {
            selectedItem = value;
          });
        },
        items: widget.items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
      ),
    );
  }
}
