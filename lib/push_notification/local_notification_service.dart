import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderStatusCubit/order_status_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SignatureScreen/signature_partial_pay.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SignatureScreen/signature_pay_later.dart';
import 'package:tojjar_delivery_app/main.dart';
import 'package:tojjar_delivery_app/push_notification/assigned_model_payload.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  /// handle action
}

class MyNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static DarwinInitializationSettings initializationSettingsDarwin =
      const DarwinInitializationSettings(
    notificationCategories: [
      DarwinNotificationCategory(
        'Tojjar',
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.customDismissAction,
        },
      )
    ],
  );

  static final InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  static initializeNotification(
      {required BuildContext context, required GlobalKey globalKey}) {
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("App Open Notification");
        final loginUser = MySharedPrefs.getUser();

        String data = details.payload.toString();

        String result = data
            .replaceAll("{", "{\"")
            .replaceAll("}", "\"}")
            .replaceAll(":", "\":\"")
            .replaceAll(",", "\",\"");
        PayLoadModel payLoad = payLoadModelFromJson(result);

        if (loginUser == null) {
          Navigator.pushNamed(
              navigatorKey.currentContext!, Strings.splashScreen);
        } else {
          if (payLoad.route.toString().trim() == '/assignedAndPickedOrders') {
            BlocProvider.of<OrderStatus>(navigatorKey.currentContext!)
                .changeStatus(0);
            Navigator.of(navigatorKey.currentContext!)
                .pushNamed(payLoad.route.toString().trim());
          } else if (payLoad.route.toString().trim() == '/signaturePayLater') {
            Navigator.push<dynamic>(
              navigatorKey.currentContext!,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      ESignaturePayLaterScreen(orderId: payLoad.itemTypeId)),

              ///if you want to disable back feature set to false
            );
          } else if (payLoad.route.toString().trim() ==
              '/signaturePartialPay') {
            Navigator.push<dynamic>(
              navigatorKey.currentContext!,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      SignaturePartialPay(orderId: payLoad.itemTypeId)),
              //if you want to disable back feature set to false
            );
          } else {
            Navigator.of(navigatorKey.currentContext!).pushNamed(
              payLoad.route.toString().trim(),
            );
          }
        }
      },
    );
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "TojjarNotificationId",
          "TojjarNotificationChannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title.toString().tr(),
          message.notification!.body.toString().tr(),
          notificationDetails,
          payload: message.data.toString());
    } on Exception {
      rethrow;
    }
  }

  static normalNotification(id, title, body, payload) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "TojjarNotificationId",
        "TojjarNotificationChannel",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  static Future removeSingleNotifications({required int? id}) async =>
      await flutterLocalNotificationsPlugin.cancel(id!);
}
