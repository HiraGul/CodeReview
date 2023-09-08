import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/partialPaymentRejectCubit/partial_payment_reject_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/partialPaymentRepo/partial_payment_reject_repo.dart';

class PartialPaymentRejectCubit extends Cubit<PartialPaymentRejectState> {
  PartialPaymentRejectCubit() : super(PartialPaymentRejectInitialState());

  fetchPartialPaymentReject(requestId) async {
    emit(PartialPaymentRejectLoadingState());
    try {
      var result = await PartialPaymentRejectRepo()
          .getPartialPaymentRejectData(requestId);
      if (result == ApiStatusCode.ok) {
        emit(PartialPaymentRejectLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(PartialPaymentRejectNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(PartialPaymentRejectTokenExpireState());
      }
    } catch (e) {
      emit(PartialPaymentRejectErrorState(e.toString()));
    }
  }
}
