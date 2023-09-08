abstract class CityListState {}

class CityListInitialState extends CityListState {}

class CityListLoadingState extends CityListState {}

class CityListLoadedState extends CityListState {}

class CityListNoInternetState extends CityListState {}

class CityListTokenExpireState extends CityListState {}

class CityListNoDataState extends CityListState {}

class CityListErrorState extends CityListState {
  String error;
  CityListErrorState(this.error);
}
