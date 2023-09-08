import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/partial_payment_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/partial_payment_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/my_error_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'create_partial_paymenr_request_cubit_state.dart';

class CreatePartialPaymenrRequestCubitCubit
    extends Cubit<CreatePartialPaymenrRequestCubitState> {
  CreatePartialPaymenrRequestCubitCubit()
      : super(CreatePartialPaymenrRequestCubitInitial());
  createPartialPaymentRequest(
      {required String orderId, required String orderAmount}) async {
    try {
      emit(CreatePartialPaymenrRequestCubitCreating());
      var statusCode = await PartialPaymentRepo.createPartialPaymentRequest(
          orderId: orderId, orderAmount: orderAmount);

      if (statusCode == ApiStatusCode.ok) {
        var requestId = PartialPaymentController.partialPaymentModel!.data.id;
        var topic = 'partialPaymentRequestResponse-$requestId';
        await FirebaseMessaging.instance.subscribeToTopic(topic);
        emit(CreatePartialPaymenrRequestCubitCreated());
      } else {
        emit(
          CreatePartialPaymenrRequestCubitFailed(
            myErrorModel: ApiStatusCode.getErrorMessage(statusCode: statusCode),
          ),
        );
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        emit(CreatePartialPaymenrRequestCubitSocketException());
      } else {
        emit(
          CreatePartialPaymenrRequestCubitFailed(
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
