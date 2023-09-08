import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/order_not_delivered_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/api_response_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'not_delivered_state.dart';

class NotDeliveredCubit extends Cubit<NotDeliveredState> {
  NotDeliveredCubit() : super(NotDeliveredInitial());

  orderNotDelivered({required String orderId, required String reason}) async {
    emit(NotDeliveredLoading());
    try {
      var result = await OrderNotDeliveredRepository.orderNotDelivered(
          orderId: orderId, reason: reason);

      if (result == ApiStatusCode.ok) {
        emit(NotDeliveredLoaded(
            message: ApiResponseController.apiResponseModel!.message));
      } else if (result == ApiStatusCode.socketException) {
        emit(NotDeliveredSocketException());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(NotDeliveredTokenExpired());
      } else {
        emit(NotDeliveredException(
            error: ApiResponseController.apiResponseModel!.message));
      }
    } catch (e) {
      emit(NotDeliveredException(
          error: ApiResponseController.apiResponseModel!.message));
    }
  }
}
