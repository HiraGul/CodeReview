import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';

class OrderDetailsItemBuilder extends StatelessWidget {
  const OrderDetailsItemBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
        itemCount:
            OrderDetailsController.orderDetailModel.data.orderDetails!.length,

        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                // const CheckBoxWidget(),

                // const Spacer(),

                /// Name of the quantity
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: MySharedPrefs.getLocale()!
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      OrderDetailsController.orderDetailModel.data
                          .orderDetails![index].product!.name
                          .toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 14.0.sp,
                        color: const Color(0xFF292929),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: MySharedPrefs.getLocale()!
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                      '(${OrderDetailsController.orderDetailModel.data.orderDetails![index].quantity}x)',
                      style: GoogleFonts.openSans(
                        fontSize: 12.0,
                        color: const Color(0xFF292929).withOpacity(0.51),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },

        /// this separatorBuilder is the line between the
        /// items
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
          );
        },
      ),
    );
  }
}
