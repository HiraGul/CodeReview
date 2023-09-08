abstract class AllCustomerState {}

class AllCustomerInitialState extends AllCustomerState {}

class AllCustomerLoadingState extends AllCustomerState {}

class AllCustomerLoadedState extends AllCustomerState {}

class AllCustomerNoInternetState extends AllCustomerState {}

class AllCustomerTokenExpireState extends AllCustomerState {}

class AllCustomerNoDataState extends AllCustomerState {}

class AllCustomerErrorState extends AllCustomerState {
  String error;
  AllCustomerErrorState(this.error);
}
