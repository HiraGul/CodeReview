import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/all_order_repo.dart';
import 'all_order_state.dart';

class AllOrderCubit extends Cubit<AllOrderState> {
  AllOrderCubit() : super(AllOrderInitialState());

  fetchAllOrder() async {
    emit(AllOrderLoadingState());
    try {
      var result = await AllOrderRepo().getAllOrderData();
      if (result == ApiStatusCode.ok) {
        emit(AllOrderLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(AllOrderNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(AllOrderTokenExpireState());
      } else if (result == 00) {
        emit(AllOrderNoDataState());
      }
    } catch (e) {
      emit(AllOrderErrorState(e.toString()));
    }
  }
}
