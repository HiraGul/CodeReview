abstract class PartialPaymentApproveState {}

class PartialPaymentApproveInitialState extends PartialPaymentApproveState {}

class PartialPaymentApproveLoadingState extends PartialPaymentApproveState {}

class PartialPaymentApproveLoadedState extends PartialPaymentApproveState {}

class PartialPaymentApproveNoInternetState extends PartialPaymentApproveState {}

class PartialPaymentApproveTokenExpireState
    extends PartialPaymentApproveState {}

class PartialPaymentApproveNoDataState extends PartialPaymentApproveState {}

class PartialPaymentApproveErrorState extends PartialPaymentApproveState {
  String error;
  PartialPaymentApproveErrorState(this.error);
}
