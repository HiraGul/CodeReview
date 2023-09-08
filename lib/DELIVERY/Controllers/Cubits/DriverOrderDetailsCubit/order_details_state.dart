part of 'order_details_cubit.dart';

@immutable
abstract class OrderDetailsState {}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsLoaded extends OrderDetailsState {}

class OrderDetailsTokenExpired extends OrderDetailsState {}

class OrderDetailsException extends OrderDetailsState {}

class OrderDetailsSocketException extends OrderDetailsState {}
