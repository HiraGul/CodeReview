abstract class PartialPaymentRejectState {}

class PartialPaymentRejectInitialState extends PartialPaymentRejectState {}

class PartialPaymentRejectLoadingState extends PartialPaymentRejectState {}

class PartialPaymentRejectLoadedState extends PartialPaymentRejectState {}

class PartialPaymentRejectNoInternetState extends PartialPaymentRejectState {}

class PartialPaymentRejectTokenExpireState extends PartialPaymentRejectState {}

class PartialPaymentRejectNoDataState extends PartialPaymentRejectState {}

class PartialPaymentRejectErrorState extends PartialPaymentRejectState {
  String error;
  PartialPaymentRejectErrorState(this.error);
}
