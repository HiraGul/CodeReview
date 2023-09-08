abstract class RequestHistoryState {}

class RequestHistoryInitialState extends RequestHistoryState {}

class RequestHistoryLoadingState extends RequestHistoryState {}

class RequestHistoryLoadedState extends RequestHistoryState {}

class RequestHistoryNoInternetState extends RequestHistoryState {}

class RequestHistoryTokenExpireState extends RequestHistoryState {}

class RequestHistoryNoDataState extends RequestHistoryState {}

class RequestHistoryErrorState extends RequestHistoryState {
  String error;
  RequestHistoryErrorState(this.error);
}
