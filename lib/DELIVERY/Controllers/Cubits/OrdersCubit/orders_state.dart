part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {}

class OrdersSocketException extends OrdersState {}

class OrderTokenExpired extends OrdersState {}

class OrdersException extends OrdersState {}
