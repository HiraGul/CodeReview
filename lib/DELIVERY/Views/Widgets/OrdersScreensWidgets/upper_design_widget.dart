import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderStatusCubit/order_status_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/assigned_picked_orders_widget.dart';

class UpperDesignWidget extends StatelessWidget {
  const UpperDesignWidget({
    Key? key,
    required this.controller,
    required this.state,
  }) : super(key: key);

  final PageController controller;
  final int state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
              onTap: (() {
                BlocProvider.of<OrderStatus>(context).changeStatus(0);
                controller.jumpToPage(0);
              }),
              child: AssignedPickedOrderCard(
                  title: 'Assigned'.tr(),
                  value:
                      '${OrderModelController.assignedOrdersModel.data.length}',
                  textColor: state == 0 ? AppColors.primaryColor : Colors.black,
                  color:
                      state == 1 ? AppColors.lightGrey : AppColors.lightBlue)),
        ),
        Expanded(
            child: GestureDetector(
                onTap: (() {
                  BlocProvider.of<OrderStatus>(context).changeStatus(1);
                  controller.jumpToPage(1);
                }),
                child: AssignedPickedOrderCard(
                    title: 'Picked Orders'.tr(),
                    value:
                        '${OrderModelController.pickedOrdersModel.data.length}',
                    textColor:
                        state == 1 ? AppColors.primaryColor : Colors.black,
                    color: state == 0
                        ? AppColors.lightGrey
                        : AppColors.lightBlue))),
      ],
    );
  }
}
