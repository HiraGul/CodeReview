import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/partial_payment_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/my_error_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'check_partial_pay_request_state.dart';

class CheckPartialPayRequestCubit extends Cubit<CheckPartialPayRequestState> {
  CheckPartialPayRequestCubit() : super(CheckPartialPayRequestInitial());
  createPartialPaymentRequest({
    required String orderId,
  }) async {
    try {
      emit(CheckPartialPayRequestLoading());
      var statusCode = await PartialPaymentRepo.checkPartialPaymentRequest(
        orderId: orderId,
      );
      if (statusCode == ApiStatusCode.ok) {
        emit(CheckPartialPayRequestLoaded());
      } else {
        emit(
          CheckPartialPayRequestException(
            myErrorModel: ApiStatusCode.getErrorMessage(statusCode: statusCode),
          ),
        );
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        emit(CheckPartialPayRequestSocketException());
      } else {
        emit(
          CheckPartialPayRequestException(
            myErrorModel: MyErrorModel(
                statusCode: '',
                message: 'Something went wrong',
                description: e.toString()),
          ),
        );
      }
    }
  }
}
