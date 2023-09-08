import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CheckPartialPayRequest/check_partial_pay_request_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CheckPayLaterCubit/check_pay_later_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/CreatePartialPaymentRequest/create_partial_paymenr_request_cubit_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/DriverOrderDetailsCubit/order_details_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/check_box_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/deliveries_length.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/price.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/sub_total.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/InvoiceSummaryCubits/tax_amount.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/ItemsEditCubit/items_edit_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/NotDeliveredCubit/not_delivered_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/NotDeliveredReasonCubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OnHoldSetDateCubit/on_hold_date_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderOnHoldCubit/order_on_hold_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderResheduleCubit/order_reschedule_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderRevisitCubit/order_revisit_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderSummaryCubit/order_summary_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrdersCubit/orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/PartialPaymentNotificationCubit/partial_payment_notification_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/PayLaterNotificationCubit/pay_later_notification_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/PickOrdersCubit/pick_orders_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/RescheduledSetDateCubit/new_date_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/RevisitReasonCubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/SIgnatureHideCubit/signature_hide.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/UpdatePriority/update_priority_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/delivered_cubit/delivered_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/delivered_cubit/select_all_cubit.dart';

import '../../Controllers/Cubits/DeliveryStartedAnimationCubit/animation_cubit.dart';
import '../../Controllers/Cubits/OrderStatusCubit/order_status_cubit.dart';
import '../../Controllers/Cubits/pay_later_cubit/pay_later_cubit.dart';

final drivers = [
  BlocProvider<ItemsEdit>(
    create: (context) => ItemsEdit([]),
  ),
  BlocProvider<AnimationCubit>(
    create: (context) => AnimationCubit(false),
  ),
  BlocProvider<OrderStatus>(
    create: (context) => OrderStatus(0),
  ),
  BlocProvider<OrderSummaryCubit>(create: (context) => OrderSummaryCubit()),
  BlocProvider<OrdersCubit>(create: (context) => OrdersCubit()),
  BlocProvider<OrderDetailsCubit>(create: (context) => OrderDetailsCubit()),
  BlocProvider<RescheduledSetNewDateCubit>(
      create: (context) => RescheduledSetNewDateCubit()),
  BlocProvider<OnHoldSetNewDateCubit>(
      create: (context) => OnHoldSetNewDateCubit()),
  BlocProvider<NotDeliveredCubit>(create: (context) => NotDeliveredCubit()),
  BlocProvider<NotDeliveredReason>(create: (context) => NotDeliveredReason()),
  BlocProvider<OrderOnHoldCubit>(create: (context) => OrderOnHoldCubit()),
  BlocProvider<OrderRescheduleCubit>(
      create: (context) => OrderRescheduleCubit()),
  BlocProvider<RevisitReason>(create: (context) => RevisitReason()),
  BlocProvider<OrderRevisitCubit>(create: (context) => OrderRevisitCubit()),
  BlocProvider<PickOrdersCubit>(create: (context) => PickOrdersCubit()),
  BlocProvider<UpdatePriorityCubit>(create: (context) => UpdatePriorityCubit()),
  BlocProvider<PriceCubit>(create: (context) => PriceCubit(0.0)),
  BlocProvider<SubTotalCubit>(create: (context) => SubTotalCubit(0.0)),
  BlocProvider<TaxAmountCubit>(create: (context) => TaxAmountCubit(0.0)),
  BlocProvider<SelectSingleProductCubit>(
      create: (context) => SelectSingleProductCubit([])),
  BlocProvider<DeliveriesLength>(create: (context) => DeliveriesLength(0)),
  BlocProvider<SignatureHideCubit>(
      create: (context) => SignatureHideCubit(true)),
  BlocProvider<PayLaterNotificationCubit>(
      create: (context) => PayLaterNotificationCubit()),
  BlocProvider<PayLaterCubit>(
    create: (context) => PayLaterCubit(),
  ),
  BlocProvider<DeliveredCubit>(
    create: (context) => DeliveredCubit(),
  ),
  BlocProvider<SelectAllCubit>(
    create: (context) => SelectAllCubit(true),
  ),
  BlocProvider<CheckPayLaterCubit>(
    create: (context) => CheckPayLaterCubit(),
  ),
  BlocProvider<CreatePartialPaymenrRequestCubitCubit>(
    create: (context) => CreatePartialPaymenrRequestCubitCubit(),
  ),
  BlocProvider<CheckPartialPayRequestCubit>(
    create: (context) => CheckPartialPayRequestCubit(),
  ),
  BlocProvider<PartialPaymentNotificationCubit>(
    create: (context) => PartialPaymentNotificationCubit(),
  ),
];
