import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderStatusCubit/order_status_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/assigned_orders.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/delivery_started_prev.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/delivery_started_upper_widget.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/map_stop_delivery_buttons.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/picked_orders.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/start_delivery_button_widget.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/OrdersScreensWidgets/upper_design_widget.dart';

import '../../../Controllers/Cubits/OrdersCubit/orders_cubit.dart';

class AssignedAndPickedOrders extends StatefulWidget {
  final int pageValue;

  const AssignedAndPickedOrders({required this.pageValue, Key? key})
      : super(key: key);

  @override
  State<AssignedAndPickedOrders> createState() =>
      _AssignedAndPickedOrdersState();
}

class _AssignedAndPickedOrdersState extends State<AssignedAndPickedOrders> {
  late PageController controller;

  apiCall()async{
    BlocProvider.of<OrdersCubit>(context).getOrdersCubit();
    controller = PageController(initialPage: widget.pageValue);
 await   Future.delayed(Duration(milliseconds: 500));
    BlocProvider.of<OrderStatus>(context).changeStatus(widget.pageValue);
  }
  @override
  void initState() {
    apiCall();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pushNamedAndRemoveUntil(
        //     context, Strings.deliveryHomeScreen, (route) => false);
        return Future.value(true);
      },
      child: Scaffold(
        /// buttons
        bottomNavigationBar: BlocBuilder<OrderStatus, int>(
          builder: (context, state) {
            return state == 1
                ? StartDeliveryButtonWidget(controller: controller)
                : state == 2
                    ? MapAndDeliveryButtons(
                        controller: controller,
                      )
                    : const SizedBox();
          },
        ),
        backgroundColor: AppColors.appBackgroundColor,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              /// upper pageView widgets
              BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  return BlocBuilder<OrderStatus, int>(
                    builder: (context, state) {
                      return state == 2
                          ? const DeliveryStartedUpperWidget()
                          : UpperDesignWidget(
                              controller: controller,
                              state: state,
                            );
                    },
                  );
                },
              ),
              SizedBox(
                height: 1.sh,
                child: PageView(
                  controller: controller,
               pageSnapping: false,
               padEnds: false,
               physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (x) async {

                    BlocProvider.of<OrderStatus>(context).changeStatus(x);
                  },
                  children: [
                    /// assigned orders screen
                    const AssignedOrders(),

                    /// locally picked orders screen
                    PickedOrders(
                      controller: controller,
                    ),

                    /// picked orders (from api ) screen
                    DeliveryStartedPrevious(
                      controller: controller,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
