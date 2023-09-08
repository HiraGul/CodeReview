import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPaymentApproveCubit/partial_payment_approve_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/partialPaymentRepo/partial_payment_approve_repo.dart';

class PartialPaymentApproveCubit extends Cubit<PartialPaymentApproveState> {
  PartialPaymentApproveCubit() : super(PartialPaymentApproveInitialState());

  fetchPartialPaymentApprove(requestId) async {
    emit(PartialPaymentApproveLoadingState());
    try {
      var result = await PartialPaymentApproveRepo()
          .getPartialPaymentApproveData(requestId);
      if (result == ApiStatusCode.ok) {
        emit(PartialPaymentApproveLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(PartialPaymentApproveNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(PartialPaymentApproveTokenExpireState());
      }
    } catch (e) {
      emit(PartialPaymentApproveErrorState(e.toString()));
    }
  }
}
