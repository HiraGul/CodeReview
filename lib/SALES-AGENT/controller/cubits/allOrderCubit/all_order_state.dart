abstract class AllOrderState {}

class AllOrderInitialState extends AllOrderState {}

class AllOrderLoadingState extends AllOrderState {}

class AllOrderLoadedState extends AllOrderState {}

class AllOrderNoInternetState extends AllOrderState {}

class AllOrderTokenExpireState extends AllOrderState {}

class AllOrderNoDataState extends AllOrderState {}

class AllOrderErrorState extends AllOrderState {
  String error;
  AllOrderErrorState(this.error);
}
