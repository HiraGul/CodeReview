import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/customer_checkin_repo.dart';
import 'customer_checkin_state.dart';

class CustomerCheckInCubit extends Cubit<CustomerCheckInState> {
  CustomerCheckInCubit() : super(CustomerCheckInInitialState());

  fetchCustomerCheckInData() async {
    emit(CustomerCheckInLoadingState());
    try {
      var result = await CustomerCheckInRepo().getCustomerCheckInData();
      if (result == ApiStatusCode.ok) {
        emit(CustomerCheckInLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(CustomerCheckInNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(CustomerCheckInErrorState(''));
      }
    } catch (e) {
      emit(CustomerCheckInErrorState(e.toString()));
    }
  }
}
