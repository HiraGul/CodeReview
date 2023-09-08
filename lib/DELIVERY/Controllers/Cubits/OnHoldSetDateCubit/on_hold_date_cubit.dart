import 'package:bloc/bloc.dart';

class OnHoldSetNewDateCubit extends Cubit<DateTime> {
  OnHoldSetNewDateCubit() : super(DateTime.now());

  changeStatus(DateTime x) {
    emit(x);
  }
}
