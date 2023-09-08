abstract class LoginAsCustomer1State {}

class LoginAsCustomer1InitialState extends LoginAsCustomer1State {}

class LoginAsCustomer1LoadingState extends LoginAsCustomer1State {}

class LoginAsCustomer1LoadedState extends LoginAsCustomer1State {}

class LoginAsCustomer1NoInternetState extends LoginAsCustomer1State {}

class LoginAsCustomer1TokenExpireState extends LoginAsCustomer1State {}

class LoginAsCustomer1NoDataState extends LoginAsCustomer1State {}

class LoginAsCustomer1NoUserState extends LoginAsCustomer1State {}

class LoginAsCustomer1ErrorState extends LoginAsCustomer1State {
  String error;
  LoginAsCustomer1ErrorState(this.error);
}
