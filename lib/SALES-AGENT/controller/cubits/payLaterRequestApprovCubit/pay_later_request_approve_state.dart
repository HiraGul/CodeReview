abstract class PayLaterRequestApproveState {}

class PayLaterRequestApproveInitialState extends PayLaterRequestApproveState {}

class PayLaterRequestApproveLoadingState extends PayLaterRequestApproveState {}

class PayLaterRequestApproveLoadedState extends PayLaterRequestApproveState {}

class PayLaterRequestApproveNoInternetState
    extends PayLaterRequestApproveState {}

class PayLaterRequestApproveTokenExpireState
    extends PayLaterRequestApproveState {}

class PayLaterRequestApproveNoDataState extends PayLaterRequestApproveState {}

class PayLaterRequestApproveErrorState extends PayLaterRequestApproveState {
  String error;
  PayLaterRequestApproveErrorState(this.error);
}
