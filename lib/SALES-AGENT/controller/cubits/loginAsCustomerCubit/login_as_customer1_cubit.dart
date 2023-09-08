import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/loginAsCustomerCubit/login_as_customer1_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/login_as_customer_repo.dart';

class LoginAsCustomer1Cubit extends Cubit<LoginAsCustomer1State> {
  LoginAsCustomer1Cubit() : super(LoginAsCustomer1InitialState());

  fetchLoginAsCustomer1(id) async {
    emit(LoginAsCustomer1LoadingState());
    try {
      var result = await LoginAsCustomerRepo.getLoginAsCustomerData(id);
      if (result == ApiStatusCode.ok) {
        emit(LoginAsCustomer1LoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(LoginAsCustomer1NoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(LoginAsCustomer1TokenExpireState());
      } else if (result == ApiStatusCode.badRequest) {
        emit(LoginAsCustomer1ErrorState(''));
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(LoginAsCustomer1NoUserState());
      }
    } catch (e) {
      emit(LoginAsCustomer1ErrorState(e.toString()));
    }
  }
}
