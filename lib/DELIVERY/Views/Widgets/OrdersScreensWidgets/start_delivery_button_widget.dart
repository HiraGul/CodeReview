import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/MapScreen/continue_delivery.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/AuthenticationWidgets/custom_button.dart';
import 'package:tojjar_delivery_app/commonWidgets/snackbar.dart';

class StartDeliveryButtonWidget extends StatelessWidget {
  const StartDeliveryButtonWidget({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.sp),
      child: CustomButton(
        iconCheck: 3,
        onTap: () {
          if (OrderModelController.pickedOrdersModel.data.isNotEmpty) {
            if (OrderModelController.pickedOrdersModel.data.isNotEmpty &&
                OrderModelController.assignedOrdersModel.data.isEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContinueDeliveryScreen(
                            controller: controller,
                          )));
            } else {
              showMessageSnackBar(
                  context, 'Please Pick all assigned Orders to proceed'.tr());
            }
          }
        },
        title: 'Start Delivery'.tr(),
        buttonColor: OrderModelController.pickedOrdersModel.data.isNotEmpty &&
                OrderModelController.assignedOrdersModel.data.isEmpty
            ? AppColors.primaryColor
            : AppColors.greyColor,
        textColor: AppColors.whiteColor,
      ),
    );
  }
}
