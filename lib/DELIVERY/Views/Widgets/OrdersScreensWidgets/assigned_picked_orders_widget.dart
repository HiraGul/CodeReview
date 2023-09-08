import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/commonWidgets/list_lenth_loading.dart';

class AssignedPickedOrderCard extends StatelessWidget {
  final String title;
  final String value;
  final Color textColor;
  final Color color;

  const AssignedPickedOrderCard(
      {required this.color,
      required this.title,
      required this.textColor,
      required this.value,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 207.0.sp,
      height: 58.0.sp,
      decoration: BoxDecoration(
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE1E1E1),
            offset: Offset(0, -0.5),
            blurRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: GoogleFonts.openSans(
                    fontSize: 14.0,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    height: 0.86,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            title == 'Assigned'
                ? Expanded(
                    child: BlocBuilder<OrdersCubit, OrdersState>(
                      builder: (context, state) {
                        if (state is OrdersLoading) {
                          return listLoadingIndicator(
                            color: AppColors.primaryColor,
                          );
                        }
                        return Align(
                          alignment: Alignment.center,
                          child: Text(
                            OrderModelController.assignedOrdersModel.data.length
                                .toString(),
                            style: GoogleFonts.openSans(
                              fontSize: 24.0.sp,
                              color: textColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      value,
                      style: GoogleFonts.openSans(
                        fontSize: 24.0.sp,
                        color: textColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
