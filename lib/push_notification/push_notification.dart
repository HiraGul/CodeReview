import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tojjar_delivery_app/DELIVERY/Controllers/Cubits/OrderStatusCubit/order_status_cubit.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SignatureScreen/signature_partial_pay.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SignatureScreen/signature_pay_later.dart';

import 'local_notification_service.dart';

class PushNotification {
  static initNotification(
      {required BuildContext context, required GlobalKey globalKey}) {
    /// 1. This method call when app in terminated state and you get a notification
    /// when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message?.notification != null) {
          print("terminated Notification");
          final loginUser = MySharedPrefs.getUser();
          final routeFromMessage = message?.data["route"];
          final orderId = message?.data["item_type_id"];

          if (loginUser == null) {
            Navigator.pushNamed(
                globalKey.currentContext!, Strings.splashScreen);
          } else {
            Navigator.pushNamed(
                globalKey.currentContext!, Strings.splashScreen);
            if (routeFromMessage == '/assignedAndPickedOrders') {
              BlocProvider.of<OrderStatus>(globalKey.currentContext!)
                  .changeStatus(0);
              Navigator.of(globalKey.currentContext!).pushNamedAndRemoveUntil(
                  routeFromMessage, (Route<dynamic> route) => false);

              // Navigator.of(context).pushNamed(routeFromMessage);
            } else if (routeFromMessage.toString().trim() ==
                '/signaturePayLater') {
              Navigator.pushAndRemoveUntil<dynamic>(
                globalKey.currentContext!,
                MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => ESignaturePayLaterScreen(
                          orderId: orderId,
                          isTerminatedState: true,
                        )),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            } else if (routeFromMessage.toString().trim() ==
                '/signaturePartialPay') {
              Navigator.pushAndRemoveUntil<dynamic>(
                globalKey.currentContext!,
                MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => SignaturePartialPay(
                          orderId: orderId,
                          isTerminatedState: true,
                        )),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            } else {
              Navigator.of(globalKey.currentContext!).pushNamedAndRemoveUntil(
                  routeFromMessage, (Route<dynamic> route) => false);
            }
          }
        }
      },
    );

    /// 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          MyNotificationService.createAndDisplayNotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("Background Notification");
        if (message.notification != null) {
          final loginUser = MySharedPrefs.getUser();
          final routeFromMessage = message.data["route"];
          final orderId = message.data["item_type_id"];

          if (loginUser == null) {
            Navigator.pushNamed(context, Strings.splashScreen);
          } else {
            if (routeFromMessage == '/assignedAndPickedOrders') {
              BlocProvider.of<OrderStatus>(globalKey.currentContext!)
                  .changeStatus(0);
              Navigator.of(globalKey.currentContext!)
                  .pushNamed(routeFromMessage);
            } else if (routeFromMessage.toString().trim() ==
                '/signaturePayLater') {
              Navigator.push(
                globalKey.currentContext!,
                MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) =>
                        ESignaturePayLaterScreen(orderId: orderId)),
              );
            } else if (routeFromMessage.toString().trim() ==
                '/signaturePartialPay') {
              Navigator.push(
                globalKey.currentContext!,
                MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) =>
                        SignaturePartialPay(orderId: orderId)),
              );
            } else {
              Navigator.of(context).pushNamed(
                routeFromMessage,
              );
            }
          }
        }
      },
    );
  }
}
