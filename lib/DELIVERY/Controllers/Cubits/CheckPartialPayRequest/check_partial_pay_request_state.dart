// ignore_for_file: must_be_immutable

part of 'check_partial_pay_request_cubit.dart';

@immutable
abstract class CheckPartialPayRequestState {}

class CheckPartialPayRequestInitial extends CheckPartialPayRequestState {}

class CheckPartialPayRequestLoading extends CheckPartialPayRequestState {}

class CheckPartialPayRequestLoaded extends CheckPartialPayRequestState {}

class CheckPartialPayRequestSocketException
    extends CheckPartialPayRequestState {}

class CheckPartialPayRequestException extends CheckPartialPayRequestState {
  MyErrorModel myErrorModel;
  CheckPartialPayRequestException({required this.myErrorModel});
}
