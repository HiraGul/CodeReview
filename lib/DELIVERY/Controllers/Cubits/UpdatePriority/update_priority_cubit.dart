import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/update_priority.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/api_response_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/pick_order_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'update_priority_state.dart';

class UpdatePriorityCubit extends Cubit<UpdatePriorityState> {
  UpdatePriorityCubit() : super(UpdatePriorityInitial());
  pickOrders({required List<PickOrderModel> pickOrderModel}) async {
    emit(UpdatePriorityLoading());
    try {
      var result = await UpdatePriorityRepo.updatePriority(
          pickOrderModel: pickOrderModel);

      if (result == ApiStatusCode.ok) {
        emit(UpdatePrioritySuccess(
            message: ApiResponseController.apiResponseModel!.message));
      } else if (result == ApiStatusCode.socketException) {
        emit(UpdatePrioritySocketException());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(UpdatePriorityFailed(
            message: ApiResponseController.apiResponseModel!.message));
      } else {
        emit(UpdatePriorityFailed(
            message: ApiResponseController.apiResponseModel!.message));
      }
    } catch (e) {
      emit(UpdatePriorityFailed(
          message: ApiResponseController.apiResponseModel!.message));
    }
  }
}
