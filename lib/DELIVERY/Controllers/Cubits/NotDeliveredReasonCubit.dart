import 'package:bloc/bloc.dart';

class NotDeliveredReason extends Cubit<String?> {
  NotDeliveredReason() : super('Wrong Location');
  selectReason({required String? reason}) => emit(reason);
}
