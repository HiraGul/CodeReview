import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/controller/repositries/order_detail_repo.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit() : super(OrderDetailInitialState());

  fetchOrderDetail(id) async {
    emit(OrderDetailLoadingState());
    try {
      var result = await OrderDetailRepo.getOrderDetailData(id);
      if (result == ApiStatusCode.ok) {
        emit(OrderDetailLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(OrderDetailNoInternetState());
      } else if (result == ApiStatusCode.unAuthorized) {
        emit(OrderDetailTokenExpireState());
      } else if (result == ApiStatusCode.badRequest) {
        emit(OrderDetailErrorState(''));
      }
    } catch (e) {
      emit(OrderDetailErrorState(e.toString()));
    }
  }
}
