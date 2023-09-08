import 'package:bloc/bloc.dart';

class EyeCubit extends Cubit<bool> {
  EyeCubit(super.initialState);

  getIcon({required checkIcon}) {
    emit(checkIcon);
  }
}
