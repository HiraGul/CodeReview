import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/customer_detail_repo.dart';
import 'customer_detail_state.dart';

class CustomerDetailCubit extends Cubit<CustomerDetailState> {
  CustomerDetailCubit() : super(CustomerDetailInitialState());

  fetchCustomerDetailData(id) async {
    emit(CustomerDetailLoadingState());
    try {
      var result = await CustomerDetailRepo().getCustomerDetailData(id);
      if (result == ApiStatusCode.ok) {
        emit(CustomerDetailLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(CustomerDetailNoInternetState());
      } else if (result == ApiStatusCode.requestTimeOut) {
        emit(CustomerDetailTokenExpireState());
      }
    } catch (e) {
      emit(CustomerDetailErrorState(e.toString()));
    }
  }
}
