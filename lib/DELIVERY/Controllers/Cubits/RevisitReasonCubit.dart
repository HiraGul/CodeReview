import 'package:bloc/bloc.dart';

class RevisitReason extends Cubit<String?> {
  RevisitReason() : super('Reason 1');
  selectReason({required String? reason}) => emit(reason);
}
