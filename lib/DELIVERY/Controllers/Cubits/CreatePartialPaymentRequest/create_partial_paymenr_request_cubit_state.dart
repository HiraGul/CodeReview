// ignore_for_file: must_be_immutable

part of 'create_partial_paymenr_request_cubit_cubit.dart';

@immutable
abstract class CreatePartialPaymenrRequestCubitState {}

class CreatePartialPaymenrRequestCubitInitial
    extends CreatePartialPaymenrRequestCubitState {}

class CreatePartialPaymenrRequestCubitCreating
    extends CreatePartialPaymenrRequestCubitState {}

class CreatePartialPaymenrRequestCubitCreated
    extends CreatePartialPaymenrRequestCubitState {}

class CreatePartialPaymenrRequestCubitSocketException
    extends CreatePartialPaymenrRequestCubitState {}

class CreatePartialPaymenrRequestCubitFailed
    extends CreatePartialPaymenrRequestCubitState {
  MyErrorModel myErrorModel;
  CreatePartialPaymenrRequestCubitFailed({required this.myErrorModel});
}
