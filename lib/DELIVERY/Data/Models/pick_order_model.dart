class PickOrderModel {
  String orderId;
  String priority;
  PickOrderModel({required this.orderId, required this.priority});

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "priority": priority,
      };
}
