import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/requestHistoryCubit/request_history_state.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/payLaterRepo/request_history_repo.dart';

class RequestHistoryCubit extends Cubit<RequestHistoryState> {
  RequestHistoryCubit() : super(RequestHistoryInitialState());

  fetchRequestHistory() async {
    emit(RequestHistoryLoadingState());
    try {
      var result = await RequestHistoryRepo().getRequestHistoryData();
      if (result == ApiStatusCode.ok) {
        emit(RequestHistoryLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(RequestHistoryNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(RequestHistoryTokenExpireState());
      } else if (result == 00) {
        emit(RequestHistoryNoDataState());
      }
    } catch (e) {
      emit(RequestHistoryErrorState(e.toString()));
    }
  }
}
