import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/payLaterRequestRejectCubit/pay_later_request_reject_state.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/payLaterRepo/pay_later_request_reject_repo.dart';

class PayLaterRequestRejectCubit extends Cubit<PayLaterRequestRejectState> {
  PayLaterRequestRejectCubit() : super(PayLaterRequestRejectInitialState());

  fetchPayLaterRequestReject(requestId) async {
    emit(PayLaterRequestRejectLoadingState());
    try {
      var result = await PayLaterRequestRejectRepo()
          .getPayLaterRequestRejectData(requestId);
      if (result == ApiStatusCode.ok) {
        emit(PayLaterRequestRejectLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(PayLaterRequestRejectNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(PayLaterRequestRejectTokenExpireState());
      }
    } catch (e) {
      emit(PayLaterRequestRejectErrorState(e.toString()));
    }
  }
}
