import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/all_customer_repo.dart';
import 'all_customer_state.dart';

class AllCustomerCubit extends Cubit<AllCustomerState> {
  AllCustomerCubit() : super(AllCustomerInitialState());

  fetchAllCustomer() async {
    emit(AllCustomerLoadingState());
    try {
      var result = await AllCustomerRepo().getAllCustomerData();
      if (result == ApiStatusCode.ok) {
        emit(AllCustomerLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(AllCustomerNoInternetState());
      } else if (result == ApiStatusCode.requestTimeOut) {
        emit(AllCustomerTokenExpireState());
      } else if (result == 00) {
        emit(AllCustomerNoDataState());
      }
    } catch (e) {
      emit(AllCustomerErrorState(e.toString()));
    }
  }
}
