import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/views/widgets/my_text.dart';

import '../../data/models/customer_checkin_model.dart';
import '../../utils/app_colors.dart';

class MyDropDownButton extends StatefulWidget {
  final List<Datum> items;
  final Function(String?, dynamic) onChange;
  final int? selectedIndex;
  final String? hint;
  final bool isEnabled;
  const MyDropDownButton({
    Key? key,
    required this.items,
    required this.onChange,
    this.selectedIndex,
    this.isEnabled = true,
    this.hint,
  }) : super(key: key);

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  Datum? selectedItem;
  int? index;
  @override
  void initState() {
    // selectedItem = widget.items.first;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: 5.sp),
      // height: 45.sp,
      decoration: BoxDecoration(
          border: Border.all(color: fieldBorderColor),
          borderRadius: BorderRadius.circular(2.sp)),
      child: DropdownButton<Datum>(
        iconEnabledColor: loginBtnColor,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 3,
        isExpanded: true,
        iconSize: 20.sp,
        // style: GoogleFonts.openSans(
        //   fontSize: 14.sp,
        //   color: Colors.black,
        // ),

        borderRadius: BorderRadius.circular(2.sp),
        underline: const SizedBox(),
        hint:
            //  widget.hint == null
            //     ? const Text('')
            //     :
            Container(
          padding: EdgeInsets.only(left: 10.sp),
          child: MyText(
            text: widget.hint!,
            size: 14.sp,
            color: fieldHintColor,
          ),
        ),
        // isDense: true,
        value:
            // index != null ? widget.items[index!].shopName : null,
            index != null ? selectedItem : null,
        items: widget.items.map((Datum data) {
          index = widget.items.indexOf(data);
          return DropdownMenuItem<Datum>(
            value: data,
            child: Container(
              padding: EdgeInsets.only(left: 10.sp),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  child: Text(
                    data.shopName!,
                    style: TextStyle(
                      // color: fieldHintColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),

        onChanged: widget.isEnabled
            ? (Datum? data) {
                setState(() {
                  selectedItem = data;
                  widget.onChange(data!.shopName, data);
                  // index = widget.items.indexOf(data);
                });
              }
            : null,
      ),
    );
  }
}
