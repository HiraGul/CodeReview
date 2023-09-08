import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/order_details_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitial());

  getOrderDetailsCubit({required String orderId}) async {
    emit(OrderDetailsLoading());
    try {
      var result = await OrderDetailsRepository.orderDetails(orderId: orderId);
      if (result == ApiStatusCode.ok) {
        emit(OrderDetailsLoaded());
      } else if (result == ApiStatusCode.socketException) {
        emit(OrderDetailsSocketException());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(OrderDetailsTokenExpired());
      }
    } catch (e) {
      emit(OrderDetailsException());
    }
  }
}
