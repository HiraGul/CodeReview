import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../DELIVERY/Utils/api_status_code.dart';
import '../../repositries/add_customer_repo.dart';
import 'add_customer_state.dart';

class AddCustomerCubit extends Cubit<AddCustomerState> {
  AddCustomerCubit() : super(AddCustomerInitialState());

  addCustomer() async {
    emit(AddCustomerLoadingState());
    try {
      var result = await AddCustomerRepo().addCustomer();
      if (result == 201) {
        emit(AddCustomerLoadedState());
      } else if (result == ApiStatusCode.socketException) {
        emit(AddCustomerNoInternetState());
      } else if (result == ApiStatusCode.badRequest) {
        emit(AddCustomerBadRequest());
      } else if (result == 422) {
        emit(AddCustomerInvalidParameter());
      }
    } catch (e) {
      emit(AddCustomerErrorState(e.toString()));
    }
  }
}
