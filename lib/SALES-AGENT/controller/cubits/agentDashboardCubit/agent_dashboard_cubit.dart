import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/agent_dashboard_repo.dart';
import 'agent_dashboard_state.dart';

class AgentDashboardCubit extends Cubit<AgentDashboardState> {
  AgentDashboardCubit() : super(AgentDashboardInitialState());

  fetchAgentDashboard() async {
    emit(AgentDashboardLoadingState());
    try {
      var result = await AgentDashboardRepo().getDashboardData();
      if (result == ApiStatusCode.ok) {
        emit(AgentDashboardLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(AgentDashboardNoInternetState());
      } else if (result == ApiStatusCode.requestTimeOut) {
        emit(AgentDashboardTokenExpireState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(AgentDashboardUnAuthorizeState());
      }
    } catch (e) {
      emit(AgentDashboardErrorState(e.toString()));
    }
  }
}
