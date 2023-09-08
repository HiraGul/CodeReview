abstract class PartialHistoryRequestState {}

class PartialHistoryRequestInitialState extends PartialHistoryRequestState {}

class PartialHistoryRequestLoadingState extends PartialHistoryRequestState {}

class PartialHistoryRequestLoadedState extends PartialHistoryRequestState {}

class PartialHistoryRequestNoInternetState extends PartialHistoryRequestState {}

class PartialHistoryRequestTokenExpireState
    extends PartialHistoryRequestState {}

class PartialHistoryRequestNoDataState extends PartialHistoryRequestState {}

class PartialHistoryRequestErrorState extends PartialHistoryRequestState {
  String error;
  PartialHistoryRequestErrorState(this.error);
}
