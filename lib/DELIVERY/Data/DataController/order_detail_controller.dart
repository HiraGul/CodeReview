import 'package:tojjar_delivery_app/DELIVERY/Data/Models/order_detail_model.dart';

class OrderDetailsController {
  static OrderDetailModel orderDetailModel = OrderDetailModel(
      data: Data(
        tax: '',
        id: 0,
        deliveryStatus: '',
        grandTotal: 0,
        subTotal: '',
        code: '',
        date: '',
        shippingAddress: ShippingAddress(),
        orderDetails: [],
      ),
      success: false,
      message: '');

  static OrderDetailModel orderDetailModelCopy = OrderDetailModel(
      data: Data(
        tax: '',
        id: 0,
        deliveryStatus: '',
        grandTotal: 0,
        subTotal: '',
        code: '',
        date: '',
        shippingAddress: ShippingAddress(),
        orderDetails: [],
      ),
      success: false,
      message: '');

  static List<OrderDetails> deliveredOrderList = [];
  static List<Map<String, dynamic>> items = [];
  static double? orderTotalPrice = 0.0;
  static List<Product>? products = [];
}
