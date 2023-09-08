part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}
class ResetPasswordNoInternet extends ResetPasswordState {}
class ResetPasswordLoading extends ResetPasswordState {}
class ResetPasswordLoaded extends ResetPasswordState {}
class ResetPasswordError extends ResetPasswordState {
  final String error;

  ResetPasswordError({required this.error});
}
