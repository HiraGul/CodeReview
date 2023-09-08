abstract class CheckOutState {}

class CheckOutInitialState extends CheckOutState {}

class CheckOutLoadingState extends CheckOutState {}

class CheckOutLoadedState extends CheckOutState {}

class CheckOutNoInternetState extends CheckOutState {}

class CheckOutTokenExpireState extends CheckOutState {}

class CheckOutNoDataState extends CheckOutState {}

class CheckOutBadRequest extends CheckOutState {}

class CheckOutErrorState extends CheckOutState {
  String error;
  CheckOutErrorState(this.error);
}
