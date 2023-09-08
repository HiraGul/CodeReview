import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/getCheckInCubit/get_checkin_state.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/Get_checkin_repo.dart';
// import 'get_checkin_state.dart';

class GetCheckInCubit extends Cubit<GetCheckInState> {
  GetCheckInCubit() : super(GetCheckInInitialState());

  fetchGetCheckInData() async {
    emit(GetCheckInLoadingState());
    try {
      var result = await GetCheckInRepo().getGetCheckInData();
      if (result == ApiStatusCode.ok) {
        emit(GetCheckInLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(GetCheckInNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(GetCheckInErrorState(''));
      }
    } catch (e) {
      emit(GetCheckInErrorState(e.toString()));
    }
  }
}
