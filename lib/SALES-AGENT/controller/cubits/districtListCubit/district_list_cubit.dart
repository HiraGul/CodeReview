import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/District_list_repo.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import 'district_list_state.dart';

class DistrictListCubit extends Cubit<DistrictListState> {
  DistrictListCubit() : super(DistrictListInitialState());

  fetchDistrictListData() async {
    emit(DistrictListLoadingState());
    try {
      var result = await DistrictListRepo().getDistrictList();
      if (result == ApiStatusCode.ok) {
        emit(DistrictListLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(DistrictListNoInternetState());
      } else if (result == ApiStatusCode.sessionExpireMessage) {
        emit(DistrictListTokenExpireState());
      }
    } catch (e) {
      emit(DistrictListErrorState(e.toString()));
    }
  }
}
