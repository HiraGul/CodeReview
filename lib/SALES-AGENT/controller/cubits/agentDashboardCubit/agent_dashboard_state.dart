abstract class AgentDashboardState {}

class AgentDashboardInitialState extends AgentDashboardState {}

class AgentDashboardLoadingState extends AgentDashboardState {}

class AgentDashboardLoadedState extends AgentDashboardState {}

class AgentDashboardNoInternetState extends AgentDashboardState {}

class AgentDashboardTokenExpireState extends AgentDashboardState {}

class AgentDashboardNoDataState extends AgentDashboardState {}

class AgentDashboardUnAuthorizeState extends AgentDashboardState {}

class AgentDashboardErrorState extends AgentDashboardState {
  String error;
  AgentDashboardErrorState(this.error);
}
