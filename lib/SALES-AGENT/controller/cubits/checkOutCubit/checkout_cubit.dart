import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/checkOutCubit/checkout_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/checkout_repo.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../../data/models/checkin_model.dart';
import '../../../data/models/customer_checkin_model.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitialState());

  fetchCheckOutData(time, location) async {
    emit(CheckOutLoadingState());
    try {
      var result = await CheckOutRepo().getCheckOutData(time, location);
      if (result == ApiStatusCode.ok) {
        emit(CheckOutLoadedState());
        await MySharedPrefs.setCheckInData(CheckInModel());
        await MySharedPrefs.setCustomerData(Datum());
      } else if (result == ApiStatusCode.socketException) {
        emit(CheckOutNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(CheckOutErrorState(''));
      } else if (result == ApiStatusCode.badRequest) {
        emit(CheckOutBadRequest());
      }
    } catch (e) {
      emit(CheckOutErrorState(e.toString()));
    }
  }
}
