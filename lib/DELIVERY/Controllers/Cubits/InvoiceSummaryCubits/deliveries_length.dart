import 'package:bloc/bloc.dart';

class DeliveriesLength extends Cubit<int> {
  DeliveriesLength(super.initialState);

  deliveryLength({required int length}) {
    emit(length);
  }
}
