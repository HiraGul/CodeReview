import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPendingRequestCubit/partial_pending_request_state.dart';

import '../../repositries/partialPaymentRepo/partial_pending_request_repo.dart';

class PartialPendingRequestCubit extends Cubit<PartialPendingRequestState> {
  PartialPendingRequestCubit() : super(PartialPendingRequestInitialState());

  fetchPendingRequest() async {
    emit(PartialPendingRequestLoadingState());
    try {
      var result = await PartialPendingRequestRepo().getPendingRequestData();

      if (result == ApiStatusCode.ok) {
        emit(PartialPendingRequestLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(PartialPendingRequestNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(PartialPendingRequestTokenExpireState());
      } else if (result == 00) {
        emit(PartialPendingRequestNoDataState());
      }
    } catch (e) {
      emit(PartialPendingRequestErrorState(e.toString()));
    }
  }
}
