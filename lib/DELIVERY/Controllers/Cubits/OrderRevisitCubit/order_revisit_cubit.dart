import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/order_revisit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/api_response_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'order_revisit_state.dart';

class OrderRevisitCubit extends Cubit<OrderRevisitState> {
  OrderRevisitCubit() : super(OrderRevisitInitial());
  orderRevisit({required String orderId, required String reason}) async {
    emit(OrderRevisitLoading());
    try {
      var result = await OrderRevisitRepository.orderRevisit(
          orderId: orderId, reason: reason);

      if (result == ApiStatusCode.ok) {
        emit(OrderRevisitLoaded(
            message: ApiResponseController.apiResponseModel!.message));
      } else if (result == ApiStatusCode.socketException) {
        emit(OrderRevisitSocketException());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(OrderRevisitTokenExpired());
      } else {
        emit(OrderRevisitException(
            message: ApiResponseController.apiResponseModel!.message));
      }
    } catch (e) {
      emit(OrderRevisitException(
          message: ApiResponseController.apiResponseModel!.message));
    }
  }
}
