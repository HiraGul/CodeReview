import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/partial_payment_notification.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'partial_payment_notification_state.dart';

class PartialPaymentNotificationCubit
    extends Cubit<PartialPaymentNotificationState> {
  PartialPaymentNotificationCubit()
      : super(PartialPaymentNotificationInitial());
  partialPaymentNotification({required String saleAgentId}) async {
    try {
      emit(PartialPaymentNotificationLoading());
      var statusCode = await CreatePartialPaymentNotificationRepo
          .partialPaymentNotificationRepo(saleAgentId: saleAgentId);

      if (statusCode == ApiStatusCode.ok) {
        emit(PartialPaymentNotificationSuccess());
      } else {
        emit(PartialPaymentNotificationFailed());
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        emit(PartialPaymentNotificationNoInternet());
      } else {
        PartialPaymentNotificationFailed();
      }
    }
  }
}
