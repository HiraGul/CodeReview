abstract class LoginAsCustomerState {}

class LoginAsCustomerInitialState extends LoginAsCustomerState {}

class LoginAsCustomerLoadingState extends LoginAsCustomerState {}

class LoginAsCustomerLoadedState extends LoginAsCustomerState {}

class LoginAsCustomerNoInternetState extends LoginAsCustomerState {}

class LoginAsCustomerTokenExpireState extends LoginAsCustomerState {}

class LoginAsCustomerNoDataState extends LoginAsCustomerState {}

class LoginAsCustomerNoUserState extends LoginAsCustomerState {}

class LoginAsCustomerErrorState extends LoginAsCustomerState {
  String error;
  LoginAsCustomerErrorState(this.error);
}
