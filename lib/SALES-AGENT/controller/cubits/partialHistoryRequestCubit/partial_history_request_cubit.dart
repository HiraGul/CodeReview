import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialHistoryRequestCubit/partial_history_request_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/partialPaymentRepo/partial_history_request_repo.dart';

class PartialHistoryRequestCubit extends Cubit<PartialHistoryRequestState> {
  PartialHistoryRequestCubit() : super(PartialHistoryRequestInitialState());

  fetchHistoryRequest() async {
    emit(PartialHistoryRequestLoadingState());
    try {
      var result = await PartialRequestHistoryRepo().getRequestHistoryData();

      if (result == ApiStatusCode.ok) {
        emit(PartialHistoryRequestLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(PartialHistoryRequestNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(PartialHistoryRequestTokenExpireState());
      } else if (result == 00) {
        emit(PartialHistoryRequestNoDataState());
      }
    } catch (e) {
      emit(PartialHistoryRequestErrorState(e.toString()));
    }
  }
}
