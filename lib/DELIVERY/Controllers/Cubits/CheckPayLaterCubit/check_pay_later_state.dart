part of 'check_pay_later_cubit.dart';

@immutable
abstract class CheckPayLaterState {}

class CheckPayLaterInitial extends CheckPayLaterState {}

class CheckPayLaterLoading extends CheckPayLaterState {}

class CheckPayLaterSuccess extends CheckPayLaterState {}

class CheckPayLaterNoInternet extends CheckPayLaterState {}

class CheckPayLaterError extends CheckPayLaterState {
  final MyErrorModel model;

  CheckPayLaterError({required this.model});
}
