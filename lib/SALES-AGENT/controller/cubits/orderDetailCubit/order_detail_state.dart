abstract class OrderDetailState {}

class OrderDetailInitialState extends OrderDetailState {}

class OrderDetailLoadingState extends OrderDetailState {}

class OrderDetailLoadedState extends OrderDetailState {}

class OrderDetailNoInternetState extends OrderDetailState {}

class OrderDetailTokenExpireState extends OrderDetailState {}

class OrderDetailNoDataState extends OrderDetailState {}

class OrderDetailErrorState extends OrderDetailState {
  String error;
  OrderDetailErrorState(this.error);
}
