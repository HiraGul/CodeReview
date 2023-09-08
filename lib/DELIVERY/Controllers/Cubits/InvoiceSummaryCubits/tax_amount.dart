import 'package:bloc/bloc.dart';

class TaxAmountCubit extends Cubit<double> {
  TaxAmountCubit(super.initialState);

  setNewTaxTotal({required double newTax}) {
    emit(newTax);
  }
}
