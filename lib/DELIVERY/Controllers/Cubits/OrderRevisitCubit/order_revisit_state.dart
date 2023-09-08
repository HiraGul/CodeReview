part of 'order_revisit_cubit.dart';

@immutable
abstract class OrderRevisitState {}

class OrderRevisitInitial extends OrderRevisitState {}

class OrderRevisitLoading extends OrderRevisitState {}

class OrderRevisitLoaded extends OrderRevisitState {
  String message;
  OrderRevisitLoaded({required this.message});
}

class OrderRevisitException extends OrderRevisitState {
  String message;
  OrderRevisitException({required this.message});
}

class OrderRevisitTokenExpired extends OrderRevisitState {}

class OrderRevisitSocketException extends OrderRevisitState {}
