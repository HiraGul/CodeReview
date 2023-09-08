import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/payLaterRequestApprovCubit/pay_later_request_approve_state.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/payLaterRepo/pay_later_request_repo.dart';

class PayLaterRequestApproveCubit extends Cubit<PayLaterRequestApproveState> {
  PayLaterRequestApproveCubit() : super(PayLaterRequestApproveInitialState());

  fetchPayLaterRequestApprove(requestId, status, hour) async {
    emit(PayLaterRequestApproveLoadingState());
    try {
      var result =
          await PayLaterRequestRepo().getPayLaterRequestData(requestId, hour);
      if (result == ApiStatusCode.ok) {
        emit(PayLaterRequestApproveLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(PayLaterRequestApproveNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(PayLaterRequestApproveTokenExpireState());
      }
    } catch (e) {
      emit(PayLaterRequestApproveErrorState(e.toString()));
    }
  }
}
