import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/cubits/stateListCubit/state_list_state.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/State_list_repo.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';

class StateListCubit extends Cubit<StateListState> {
  StateListCubit() : super(StateListInitialState());

  fetchStateListData() async {
    emit(StateListLoadingState());
    try {
      var result = await StateListRepo().getStateList();
      if (result == ApiStatusCode.ok) {
        emit(StateListLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(StateListNoInternetState());
      } else if (result == ApiStatusCode.sessionExpireMessage) {
        emit(StateListTokenExpireState());
      }
    } catch (e) {
      emit(StateListErrorState(e.toString()));
    }
  }
}
