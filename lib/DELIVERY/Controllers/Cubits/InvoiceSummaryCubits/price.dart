import 'package:bloc/bloc.dart';

class PriceCubit extends Cubit<double> {
  PriceCubit(super.initialState);

  setNewPrice({required double newPrice}) {
    emit(newPrice);
  }
}
