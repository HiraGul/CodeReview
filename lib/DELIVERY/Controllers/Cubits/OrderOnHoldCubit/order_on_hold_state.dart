// ignore_for_file: must_be_immutable

part of 'order_on_hold_cubit.dart';

@immutable
abstract class OrderOnHoldState {}

class OrderOnHoldInitial extends OrderOnHoldState {}

class OrderOnHoldLoading extends OrderOnHoldState {}

class OrderOnHoldLoaded extends OrderOnHoldState {
  String message;
  OrderOnHoldLoaded({required this.message});
}

class OrderOnHoldException extends OrderOnHoldState {
  String error;
  OrderOnHoldException({required this.error});
}

class OrderOnHoldTokenExpired extends OrderOnHoldState {}

class OrderOnHoldSocketException extends OrderOnHoldState {}
