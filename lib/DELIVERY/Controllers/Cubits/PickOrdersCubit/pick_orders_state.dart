part of 'pick_orders_cubit.dart';

@immutable
abstract class PickOrdersState {}

class PickOrdersInitial extends PickOrdersState {}

class PickOrdersLoading extends PickOrdersState {}

class PickOrdersLoaded extends PickOrdersState {
  String message;
  PickOrdersLoaded({required this.message});
}

class PickOrdersSocketException extends PickOrdersState {}

class PickOrdersException extends PickOrdersState {
  String message;
  PickOrdersException({required this.message});
}
