import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/pick_order_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/api_response_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/pick_order_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'pick_orders_state.dart';

class PickOrdersCubit extends Cubit<PickOrdersState> {
  PickOrdersCubit() : super(PickOrdersInitial());
  pickOrders({required List<PickOrderModel> pickOrderModel}) async {
    emit(PickOrdersLoading());
    try {
      var result =
          await PickOrderRepo.pickOrders(pickOrderModel: pickOrderModel);
      if (result == ApiStatusCode.ok) {
        emit(PickOrdersLoaded(
            message: ApiResponseController.apiResponseModel!.message));
      } else if (result == ApiStatusCode.socketException) {
        emit(PickOrdersSocketException());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(PickOrdersException(
            message: ApiResponseController.apiResponseModel!.message));
      }
    } catch (e) {
      emit(PickOrdersException(
          message: ApiResponseController.apiResponseModel!.message));
    }
  }
}
