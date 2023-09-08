import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/Models/login_model.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_routes.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/SplashScreen/splash_screen.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/permission.dart';
import 'package:tojjar_delivery_app/push_notification/local_notification_service.dart';
import 'package:tojjar_delivery_app/push_notification/push_notification.dart';

import 'DELIVERY/Utils/Providers/providers.dart';
import 'DELIVERY/Utils/app_sharedPrefs.dart';
import 'DELIVERY/Utils/strings.dart';
import 'DELIVERY/Views/Screens/DeliveryHomeScreen/delivery_home_screen.dart';
import 'SALES-AGENT/views/Screens/saleAgentDashboard/sale_agent_dashboard.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {}
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  await MySharedPrefs.init();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  ///setting the landscape mode off
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(EasyLocalization(
      path: Strings.languagePath,
      supportedLocales: const [
        Locale('en', 'EN'),
        Locale('ar', 'AR'),
      ],
      fallbackLocale: const Locale('en', 'EN'),
      saveLocale: true,
      startLocale: const Locale('en', 'EN'),
      child: const RouteScreen()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RouteScreen extends StatelessWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
              providers: MyProviders.initialize(),
              child: BackGestureWidthTheme(
                backGestureWidth: BackGestureWidth.fraction(1 / 2),
                child: MaterialApp(
                  navigatorKey: navigatorKey,
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  locale: context.locale,
                  routes: customRoutes,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      pageTransitionsTheme: const PageTransitionsTheme(
                        builders: {
                          TargetPlatform.android:
                              CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
                          TargetPlatform.iOS:
                              CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
                        },
                      ),
                      primaryColor: AppColors.primaryColor,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      brightness: Brightness.light),
                  home: const MyApp(),
                ),
              ));
        });
  }
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LoginModel? loginUser;

  bool? serviceEnabled;
  LocationPermission? permission;
  _determinePosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled!) {
      permission = await Geolocator.requestPermission();
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Geolocator.openLocationSettings();
      setState(() {});
    } else {
      await _getCurrentPosition();
    }
  }

  Future<void> _getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      OrderModelController.currentPosition = position;

      setState(() {});
    }).catchError((e) {});
  }

  @override
  void initState() {
    super.initState();

    _determinePosition();
    MyNotificationService.initializeNotification(
        context: context, globalKey: navigatorKey);
    PushNotification.initNotification(
        context: context, globalKey: navigatorKey);

    getUser();
  }

  getUser() {
    loginUser = MySharedPrefs.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return (permission == LocationPermission.deniedForever ||
            permission == LocationPermission.denied)
        ? const PermissionScreen()
        : loginUser?.user == null
            ? const SplashScreen()
            : loginUser?.user?.userType == 'delivery_boy'
                ? const DeliveryHomeScreen()
                : const SaleAgentDashBoard();
  }
}
