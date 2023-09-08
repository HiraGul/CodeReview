import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/City_list_repo.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import 'city_list_state.dart';

class CityListCubit extends Cubit<CityListState> {
  CityListCubit() : super(CityListInitialState());

  fetchCityListData() async {
    emit(CityListLoadingState());
    try {
      var result = await CityListRepo().getCityList();
      if (result == ApiStatusCode.ok) {
        emit(CityListLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(CityListNoInternetState());
      } else if (result == ApiStatusCode.sessionExpireMessage) {
        emit(CityListTokenExpireState());
      }
    } catch (e) {
      emit(CityListErrorState(e.toString()));
    }
  }
}
