import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/order_onhold_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/api_response_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'order_on_hold_state.dart';

class OrderOnHoldCubit extends Cubit<OrderOnHoldState> {
  OrderOnHoldCubit() : super(OrderOnHoldInitial());
  orderOnHold({required String orderId, required String date}) async {
    emit(OrderOnHoldLoading());
    try {
      var result =
          await OrderOnHoldRepository.orderOnHold(orderId: orderId, date: date);

      if (result == ApiStatusCode.ok) {
        emit(OrderOnHoldLoaded(
            message: ApiResponseController.apiResponseModel!.message));
      } else if (result == ApiStatusCode.socketException) {
        emit(OrderOnHoldSocketException());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(OrderOnHoldTokenExpired());
      } else {
        emit(OrderOnHoldException(
            error: ApiResponseController.apiResponseModel!.message));
      }
    } catch (e) {
      emit(OrderOnHoldException(
          error: ApiResponseController.apiResponseModel!.message));
    }
  }
}
