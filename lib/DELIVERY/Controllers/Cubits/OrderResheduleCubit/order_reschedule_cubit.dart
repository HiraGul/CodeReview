import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/order_reshedule.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/api_response_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'order_reschedule_state.dart';

class OrderRescheduleCubit extends Cubit<OrderRescheduleState> {
  OrderRescheduleCubit() : super(OrderRescheduleInitial());
  orderRescheduled(
      {required String orderId,
      required String date,
      required String reason}) async {
    emit(OrderRescheduleLoading());
    try {
      var result = await OrderRescheduleRepository.orderReschedule(
          orderId: orderId, reason: reason, date: date);

      if (result == ApiStatusCode.ok) {
        emit(OrderRescheduleLoaded(
            message: ApiResponseController.apiResponseModel!.message));
      } else if (result == ApiStatusCode.socketException) {
        emit(OrderRescheduleSocketException());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(OrderRescheduleTokenExpired());
      } else {
        emit(OrderRescheduleException(
            message: ApiResponseController.apiResponseModel!.message));
      }
    } catch (e) {
      emit(OrderRescheduleException(
          message: ApiResponseController.apiResponseModel!.message));
    }
  }
}
