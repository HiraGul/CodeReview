part of 'pay_later_cubit.dart';

@immutable
abstract class PayLaterState {}

class PayLaterInitial extends PayLaterState {}

class PayLaterLoading extends PayLaterState {}

class PayLaterLoaded extends PayLaterState {}

class PayLaterError extends PayLaterState {
  final MyErrorModel model;

  PayLaterError({required this.model});
}

class PayLaterNoInternet extends PayLaterState {}

class PayLaterTokenExpire extends PayLaterState {}
