import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/pendingRequestCubit/pending_request_state.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/payLaterRepo/pending_request_repo.dart';

class PendingRequestCubit extends Cubit<PendingRequestState> {
  PendingRequestCubit() : super(PendingRequestInitialState());

  fetchPendingRequest() async {
    emit(PendingRequestLoadingState());
    try {
      var result = await PendingRequestRepo().getPendingRequestData();
      if (result == ApiStatusCode.ok) {
        emit(PendingRequestLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(PendingRequestNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(PendingRequestTokenExpireState());
      } else if (result == 00) {
        emit(PendingRequestNoDataState());
      }
    } catch (e) {
      emit(PendingRequestErrorState(e.toString()));
    }
  }
}
