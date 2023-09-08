import 'package:bloc/bloc.dart';

class SignatureHideCubit extends Cubit<bool> {
  SignatureHideCubit(super.initialState);

  signatureHide({required signature}) {
    emit(signature);
  }
}
