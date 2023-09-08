abstract class PartialPendingRequestState {}

class PartialPendingRequestInitialState extends PartialPendingRequestState {}

class PartialPendingRequestLoadingState extends PartialPendingRequestState {}

class PartialPendingRequestLoadedState extends PartialPendingRequestState {}

class PartialPendingRequestNoInternetState extends PartialPendingRequestState {}

class PartialPendingRequestTokenExpireState
    extends PartialPendingRequestState {}

class PartialPendingRequestNoDataState extends PartialPendingRequestState {}

class PartialPendingRequestErrorState extends PartialPendingRequestState {
  String error;
  PartialPendingRequestErrorState(this.error);
}
