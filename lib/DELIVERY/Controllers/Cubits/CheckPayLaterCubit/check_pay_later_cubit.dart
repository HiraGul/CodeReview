import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/pay_later_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

import '../../../Data/Models/my_error_model.dart';

part 'check_pay_later_state.dart';

class CheckPayLaterCubit extends Cubit<CheckPayLaterState> {
  CheckPayLaterCubit() : super(CheckPayLaterInitial());

  checkPayLater({required String orderId}) async {
    try {
      emit(CheckPayLaterLoading());
      var statusCode = await PayLaterRepo.checkPayLater(orderId: orderId);
      if (statusCode == ApiStatusCode.ok) {
        emit(CheckPayLaterSuccess());
      } else {
        emit(
          CheckPayLaterError(
            model: ApiStatusCode.getErrorMessage(statusCode: statusCode),
          ),
        );
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        emit(CheckPayLaterNoInternet());
      } else {
        emit(
          CheckPayLaterError(
            model: MyErrorModel(
                statusCode: '',
                message: 'Something went wrong',
                description: e.toString()),
          ),
        );
      }
    }
  }
}
