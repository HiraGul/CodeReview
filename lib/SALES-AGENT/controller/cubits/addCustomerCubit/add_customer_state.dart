abstract class AddCustomerState {}

class AddCustomerInitialState extends AddCustomerState {}

class AddCustomerLoadingState extends AddCustomerState {}

class AddCustomerLoadedState extends AddCustomerState {}

class AddCustomerNoInternetState extends AddCustomerState {}

class AddCustomerTokenExpireState extends AddCustomerState {}

class AddCustomerNoDataState extends AddCustomerState {}

class AddCustomerInvalidParameter extends AddCustomerState {}

class AddCustomerBadRequest extends AddCustomerState {}

class AddCustomerErrorState extends AddCustomerState {
  String error;
  AddCustomerErrorState(this.error);
}
