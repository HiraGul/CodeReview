abstract class GetCheckInState {}

class GetCheckInInitialState extends GetCheckInState {}

class GetCheckInLoadingState extends GetCheckInState {}

class GetCheckInLoadedState extends GetCheckInState {}

class GetCheckInNoInternetState extends GetCheckInState {}

class GetCheckInTokenExpireState extends GetCheckInState {}

class GetCheckInNoDataState extends GetCheckInState {}

class GetCheckInErrorState extends GetCheckInState {
  String error;
  GetCheckInErrorState(this.error);
}
