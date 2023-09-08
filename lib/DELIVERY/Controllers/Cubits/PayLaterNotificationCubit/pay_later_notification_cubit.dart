import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Repositories/create_pay_later_notification.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/api_status_code.dart';

part 'pay_later_notification_state.dart';

class PayLaterNotificationCubit extends Cubit<PayLaterNotificationState> {
  PayLaterNotificationCubit() : super(PayLaterNotificationInitial());

  payLaterNotification({required String saleAgentId}) async {
    try {
      emit(PayLaterNotificationLoading());
      var statusCode =
          await CreatePayLaterNotificationRepo.payLaterNotificationRepo(
              saleAgentId: saleAgentId);

      if (statusCode == ApiStatusCode.ok) {
        emit(PayLaterNotificationSuccess());
      } else {
        emit(PayLaterNotificationFailed());
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        emit(PayLaterNotificationNoInternet());
      } else {
        PayLaterNotificationFailed();
      }
    }
  }
}
