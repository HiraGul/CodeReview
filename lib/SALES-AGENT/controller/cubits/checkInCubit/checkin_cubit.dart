import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/checkin_repo.dart';
import 'checkin_state.dart';

class CheckInCubit extends Cubit<CheckInState> {
  CheckInCubit() : super(CheckInInitialState());

  fetchCheckInData(context, addressId, userId, time, location) async {
    emit(CheckInLoadingState());
    try {
      var result = await CheckInRepo()
          .getCheckInData(context, addressId, userId, time, location);
      if (result == ApiStatusCode.ok) {
        emit(CheckInLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(CheckInNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(CheckInErrorState(''));
      } else if (result == ApiStatusCode.badRequest) {
        emit(CheckInBadRequest());
      }
    } catch (e) {
      emit(CheckInErrorState(e.toString()));
    }
  }
}
