abstract class CustomerDetailState {}

class CustomerDetailInitialState extends CustomerDetailState {}

class CustomerDetailLoadingState extends CustomerDetailState {}

class CustomerDetailLoadedState extends CustomerDetailState {}

class CustomerDetailNoInternetState extends CustomerDetailState {}

class CustomerDetailTokenExpireState extends CustomerDetailState {}

class CustomerDetailNoDataState extends CustomerDetailState {}

class CustomerDetailErrorState extends CustomerDetailState {
  String error;
  CustomerDetailErrorState(this.error);
}
