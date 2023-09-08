import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:tojjar_delivery_app/push_notification/local_notification_service.dart';

class NotificationTimer {
  Timer? timer;

  startTimer() {
    timer = Timer.periodic(const Duration(minutes: 30), (timer) {
      MyNotificationService.normalNotification(
          0,
          "Reminder".tr(),
          "You have checked In from last 30 minutes, please check out".tr(),
          '"route":"/saleAgentDashboard","item_type_id":""," item_type":""," click_action":"FLUTTER_NOTIFICATION_CLICK"');
    });
  }

  endTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }
}
