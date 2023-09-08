import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/get_orders_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  getOrdersCubit() async {
    emit(OrdersLoading());

    var result = await GetOrdersRepo.getAllOrders();

    if (result == ApiStatusCode.ok) {
      emit(OrdersLoaded());
    } else if (result == ApiStatusCode.socketException) {
      emit(OrdersSocketException());
    } else if (result == ApiStatusCode.unAuthorized) {
      emit(OrderTokenExpired());
    } else {
      emit(OrdersException());
    }
  }
}
