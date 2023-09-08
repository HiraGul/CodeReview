import 'package:bloc/bloc.dart';

class RescheduledSetNewDateCubit extends Cubit<DateTime> {
  RescheduledSetNewDateCubit() : super(DateTime.now());

  changeStatus(DateTime x) {
    emit(x);
  }
}
