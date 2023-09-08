import 'package:bloc/bloc.dart';

class SelectAllCubit extends Cubit<bool> {
  SelectAllCubit(super.initialState);

  getSelectAll({required bool value}) {
    emit(value);
  }
}
