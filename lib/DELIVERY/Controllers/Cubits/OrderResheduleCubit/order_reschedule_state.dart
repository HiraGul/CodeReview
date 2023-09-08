part of 'order_reschedule_cubit.dart';

@immutable
abstract class OrderRescheduleState {}

class OrderRescheduleInitial extends OrderRescheduleState {}

class OrderRescheduleLoading extends OrderRescheduleState {}

class OrderRescheduleLoaded extends OrderRescheduleState {
  String message;
  OrderRescheduleLoaded({required this.message});
}

class OrderRescheduleException extends OrderRescheduleState {
  String message;
  OrderRescheduleException({required this.message});
}

class OrderRescheduleSocketException extends OrderRescheduleState {}

class OrderRescheduleTokenExpired extends OrderRescheduleState {}
