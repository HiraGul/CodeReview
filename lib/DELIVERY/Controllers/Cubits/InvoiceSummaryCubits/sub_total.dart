import 'package:bloc/bloc.dart';

class SubTotalCubit extends Cubit<double> {
  SubTotalCubit(super.initialState);

  setNewSubTotal({required double newSubTotal}) {
    emit(newSubTotal);
  }
}
