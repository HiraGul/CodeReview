abstract class OrderSummaryState {}

class OrderSummaryInitialState extends OrderSummaryState {}

class OrderSummaryLoadingState extends OrderSummaryState {}

class OrderSummaryLoadedState extends OrderSummaryState {}

class OrderSummaryNoInternetState extends OrderSummaryState {}

class OrderSummaryTokenExpireState extends OrderSummaryState {}

class OrderSummaryNoDataState extends OrderSummaryState {}

class OrderSummaryErrorState extends OrderSummaryState {
  String error;
  OrderSummaryErrorState(this.error);
}
