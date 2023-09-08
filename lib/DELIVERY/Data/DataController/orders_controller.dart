import 'package:geolocator/geolocator.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/assigned_orders_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/delivery_started_model.dart';

class OrderModelController {
  static Position? currentPosition;
  static AssignedOrderModel allOrders = AssignedOrderModel(data: []);

  /// Assigned Orders
  static AssignedOrderModel assignedOrdersModel = AssignedOrderModel(data: []);
  static List<String> distance = [];
  static List<String> kmDistance = [];

  /// Picked Orders
  static AssignedOrderModel pickedOrdersModel = AssignedOrderModel(data: []);
  static List<String> pickedDistance = [];
  static List<String> pickedKmDistance = [];

  /// Deliveries Started Orders
  static AssignedOrderModel startedDeliveries = AssignedOrderModel(data: []);
  static List<DeliveryStartedModel> deliveryStartedDistance = [];
  static List<DeliveryStartedModel> deliveryStartedKmDistance = [];
}
