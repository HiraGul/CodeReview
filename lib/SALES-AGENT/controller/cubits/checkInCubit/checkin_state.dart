abstract class CheckInState {}

class CheckInInitialState extends CheckInState {}

class CheckInLoadingState extends CheckInState {}

class CheckInLoadedState extends CheckInState {}

class CheckInNoInternetState extends CheckInState {}

class CheckInTokenExpireState extends CheckInState {}

class CheckInNoDataState extends CheckInState {}

class CheckInBadRequest extends CheckInState {}

class CheckInErrorState extends CheckInState {
  String error;
  CheckInErrorState(this.error);
}
