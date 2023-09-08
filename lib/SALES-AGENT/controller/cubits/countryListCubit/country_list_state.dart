abstract class CountryListState {}

class CountryListInitialState extends CountryListState {}

class CountryListLoadingState extends CountryListState {}

class CountryListLoadedState extends CountryListState {}

class CountryListNoInternetState extends CountryListState {}

class CountryListTokenExpireState extends CountryListState {}

class CountryListNoDataState extends CountryListState {}

class CountryListErrorState extends CountryListState {
  String error;
  CountryListErrorState(this.error);
}
