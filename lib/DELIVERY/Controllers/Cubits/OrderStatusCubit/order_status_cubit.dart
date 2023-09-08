import 'package:bloc/bloc.dart';

class OrderStatus extends Cubit<int> {
  OrderStatus(int initialState) : super(initialState);

  changeStatus(x) {
    emit(x);
  }
}
