abstract class DistrictListState {}

class DistrictListInitialState extends DistrictListState {}

class DistrictListLoadingState extends DistrictListState {}

class DistrictListLoadedState extends DistrictListState {}

class DistrictListNoInternetState extends DistrictListState {}

class DistrictListTokenExpireState extends DistrictListState {}

class DistrictListNoDataState extends DistrictListState {}

class DistrictListErrorState extends DistrictListState {
  String error;
  DistrictListErrorState(this.error);
}
