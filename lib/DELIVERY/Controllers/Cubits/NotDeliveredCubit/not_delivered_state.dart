// ignore_for_file: must_be_immutable

part of 'not_delivered_cubit.dart';

@immutable
abstract class NotDeliveredState {}

class NotDeliveredInitial extends NotDeliveredState {}

class NotDeliveredLoading extends NotDeliveredState {}

class NotDeliveredLoaded extends NotDeliveredState {
  String message;
  NotDeliveredLoaded({required this.message});
}

class NotDeliveredSocketException extends NotDeliveredState {}

class NotDeliveredTokenExpired extends NotDeliveredState {}

class NotDeliveredException extends NotDeliveredState {
  String error;
  NotDeliveredException({required this.error});
}
