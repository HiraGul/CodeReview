import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/login_as_customer_repo.dart';
import 'login_as_customer_state.dart';

class LoginAsCustomerCubit extends Cubit<LoginAsCustomerState> {
  LoginAsCustomerCubit() : super(LoginAsCustomerInitialState());

  fetchLoginAsCustomer(id) async {
    emit(LoginAsCustomerLoadingState());
    try {
      var result = await LoginAsCustomerRepo.getLoginAsCustomerData(id);
      if (result == ApiStatusCode.ok) {
        emit(LoginAsCustomerLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(LoginAsCustomerNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(LoginAsCustomerTokenExpireState());
      } else if (result == ApiStatusCode.badRequest) {
        emit(LoginAsCustomerErrorState(''));
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(LoginAsCustomerNoUserState());
      }
    } catch (e) {
      emit(LoginAsCustomerErrorState(e.toString()));
    }
  }
}
