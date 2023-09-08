import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/order_summary_repo.dart';

import '../../../Utils/api_status_code.dart';
import 'order_summary_state.dart';

class OrderSummaryCubit extends Cubit<OrderSummaryState> {
  OrderSummaryCubit() : super(OrderSummaryInitialState());

  fetchOrderSummary() async {
    emit(OrderSummaryLoadingState());
    try {
      var result = await OrderSummaryRepo().getOrdersSummary();
      if (result == ApiStatusCode.ok) {
        emit(OrderSummaryLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(OrderSummaryNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(OrderSummaryTokenExpireState());
      }
    } catch (e) {
      emit(OrderSummaryErrorState(e.toString()));
    }
  }
}
