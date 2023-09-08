import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/pay_later_repo.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/create_pay_later_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/my_error_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'pay_later_state.dart';

class PayLaterCubit extends Cubit<PayLaterState> {
  PayLaterCubit() : super(PayLaterInitial());

  requestPayLater({required String orderId}) async {
    emit(PayLaterLoading());
    try {
      var statusCode = await PayLaterRepo.requestPayLater(orderId: orderId);
      if (statusCode == ApiStatusCode.ok) {
        var payRequestId =
            CreatePayLaterController.createPayRequestModel!.data!.id;
        var topic = 'payLaterRequestResponse-$payRequestId';
        await FirebaseMessaging.instance.subscribeToTopic(topic);
        emit(PayLaterLoaded());
      } else if (statusCode == ApiStatusCode.badRequest) {
        emit(PayLaterError(
          model: ApiStatusCode.getErrorMessage(statusCode: statusCode),
        ));
      } else if (statusCode == ApiStatusCode.unAuthorized) {
        emit(PayLaterTokenExpire());
      } else {
        emit(
          PayLaterError(
            model: ApiStatusCode.getErrorMessage(statusCode: statusCode),
          ),
        );
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        emit(PayLaterNoInternet());
      } else {
        emit(
          PayLaterError(
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
