import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/country_list_repo.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import 'country_list_state.dart';

class CountryListCubit extends Cubit<CountryListState> {
  CountryListCubit() : super(CountryListInitialState());

  fetchCountryListData() async {
    emit(CountryListLoadingState());
    try {
      var result = await CountryListRepo().getCountryList();
      if (result == ApiStatusCode.ok) {
        emit(CountryListLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(CountryListNoInternetState());
      } else if (result == ApiStatusCode.sessionExpireMessage) {
        emit(CountryListTokenExpireState());
      }
    } catch (e) {
      emit(CountryListErrorState(e.toString()));
    }
  }
}
