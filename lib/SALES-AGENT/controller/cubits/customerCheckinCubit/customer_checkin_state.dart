abstract class CustomerCheckInState {}

class CustomerCheckInInitialState extends CustomerCheckInState {}

class CustomerCheckInLoadingState extends CustomerCheckInState {}

class CustomerCheckInLoadedState extends CustomerCheckInState {}

class CustomerCheckInNoInternetState extends CustomerCheckInState {}

class CustomerCheckInTokenExpireState extends CustomerCheckInState {}

class CustomerCheckInNoDataState extends CustomerCheckInState {}

class CustomerCheckInErrorState extends CustomerCheckInState {
  String error;
  CustomerCheckInErrorState(this.error);
}
