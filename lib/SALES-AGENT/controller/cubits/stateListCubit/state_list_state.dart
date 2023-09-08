abstract class StateListState {}

class StateListInitialState extends StateListState {}

class StateListLoadingState extends StateListState {}

class StateListLoadedState extends StateListState {}

class StateListNoInternetState extends StateListState {}

class StateListTokenExpireState extends StateListState {}

class StateListNoDataState extends StateListState {}

class StateListErrorState extends StateListState {
  String error;
  StateListErrorState(this.error);
}
