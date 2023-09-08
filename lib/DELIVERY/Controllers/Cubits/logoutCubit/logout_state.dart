abstract class LogoutState {}

class LogoutInitialState extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutLoadedState extends LogoutState {}

class LogoutNoInternetState extends LogoutState {}

class LogoutTokenExpireState extends LogoutState {}

class LogoutNoDataState extends LogoutState {}

class LogoutErrorState extends LogoutState {
  String error;
  LogoutErrorState(this.error);
}
