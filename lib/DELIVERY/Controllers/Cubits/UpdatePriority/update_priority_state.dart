part of 'update_priority_cubit.dart';

@immutable
abstract class UpdatePriorityState {}

class UpdatePriorityInitial extends UpdatePriorityState {}

class UpdatePriorityLoading extends UpdatePriorityState {}

class UpdatePrioritySuccess extends UpdatePriorityState {
  String message;
  UpdatePrioritySuccess({required this.message});
}

class UpdatePriorityFailed extends UpdatePriorityState {
  String message;
  UpdatePriorityFailed({required this.message});
}

class UpdatePrioritySocketException extends UpdatePriorityState {}
