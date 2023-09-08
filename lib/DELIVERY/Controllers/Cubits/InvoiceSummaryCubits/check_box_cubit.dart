import 'package:bloc/bloc.dart';

class SelectSingleProductCubit extends Cubit<List<bool>> {
  SelectSingleProductCubit(super.initialState);

  getSelectAll({required List<bool> value}) {
    emit(value);
  }
}
