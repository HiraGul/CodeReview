import 'package:tojjar_delivery_app/DELIVERY/Data/Models/order_summary_model.dart';

OrderSummaryModel orderSummaryModelController = OrderSummaryModel(
    data: Data(
        delivered: 0,
        cancelled: 0,
        pickedUp: 0,
        pending: 0,
        onTheWay: 0,
        rescheduled: 0,
        onHold: 0,
        revisit: 0,
        partialDelivered: 0),
    success: false,
    status: 0);
