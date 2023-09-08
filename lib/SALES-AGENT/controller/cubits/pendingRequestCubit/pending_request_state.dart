abstract class PendingRequestState {}

class PendingRequestInitialState extends PendingRequestState {}

class PendingRequestLoadingState extends PendingRequestState {}

class PendingRequestLoadedState extends PendingRequestState {}

class PendingRequestNoInternetState extends PendingRequestState {}

class PendingRequestTokenExpireState extends PendingRequestState {}

class PendingRequestNoDataState extends PendingRequestState {}

class PendingRequestErrorState extends PendingRequestState {
  String error;
  PendingRequestErrorState(this.error);
}
