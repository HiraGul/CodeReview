abstract class PayLaterRequestRejectState {}

class PayLaterRequestRejectInitialState extends PayLaterRequestRejectState {}

class PayLaterRequestRejectLoadingState extends PayLaterRequestRejectState {}

class PayLaterRequestRejectLoadedState extends PayLaterRequestRejectState {}

class PayLaterRequestRejectNoInternetState extends PayLaterRequestRejectState {}

class PayLaterRequestRejectTokenExpireState
    extends PayLaterRequestRejectState {}

class PayLaterRequestRejectNoDataState extends PayLaterRequestRejectState {}

class PayLaterRequestRejectErrorState extends PayLaterRequestRejectState {
  String error;
  PayLaterRequestRejectErrorState(this.error);
}
