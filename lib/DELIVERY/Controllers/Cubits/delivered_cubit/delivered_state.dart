part of 'delivered_cubit.dart';

@immutable
abstract class DeliveredState {}

class DeliveredInitial extends DeliveredState {}
class DeliveredLoading extends DeliveredState {}
class DeliveredLoaded extends DeliveredState {}
class DeliveredError extends DeliveredState {
  final MyErrorModel model;

  DeliveredError({required this.model});
}
class DeliveredTokenExpire extends DeliveredState {}
class DeliveredNoInternet extends DeliveredState {}
