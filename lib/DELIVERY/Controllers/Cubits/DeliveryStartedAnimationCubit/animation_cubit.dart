import 'package:bloc/bloc.dart';

class AnimationCubit extends Cubit<bool> {
  AnimationCubit(bool initialState) : super(initialState);

  changeStatus(x) {
    emit(x);
  }
}
