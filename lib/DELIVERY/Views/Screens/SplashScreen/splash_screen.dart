import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/images.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Screens/AuthenticationScreens/LoginScreen/login_screen.dart';
import 'package:tojjar_delivery_app/Localization/language_dropdown.dart';

import '../../../Data/Models/login_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animateCheck = false;
  bool positionCheck = false;
  bool loginCheck = false;
  LoginModel? loginModel;
  late Timer _timer;
  late Timer _timer1;
  late Timer _timer2;
  @override
  void initState() {
    loginModel = MySharedPrefs.getUser();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      animateCheck = true;
      if (context.mounted) {
        setState(() {});
      }
    });
    _timer1 = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      positionCheck = true;
      if (context.mounted) {
        setState(() {});
      }
    });
    _timer2 = Timer.periodic(const Duration(milliseconds: 2800), (timer) {
      loginCheck = true;
      if (context.mounted) {
        setState(() {});
      }
    });

    // Future.delayed(const Duration(seconds: 1), () {
    //   animateCheck = true;
    //   if (context.mounted) {
    //     setState(() {});
    //   }
    // });
    //  Future.delayed(const Duration(seconds: 2), () {
    //   positionCheck = true;
    //   if (context.mounted) {
    //     setState(() {});
    //   }
    // });
    //  Future.delayed(const Duration(milliseconds: 3070), () {
    //   loginCheck = true;
    //   if (context.mounted) {
    //     setState(() {});
    //   }
    // });
    super.initState();
  }

  String selectedOption = "English";
  var dropdownItems = ["English", "Arabic"];

  @override
  void dispose() {
    _timer.cancel();
    _timer1.cancel();
    _timer2.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // Positioned(
            //   top: 20.sp,
            //   child: positionCheck
            //       ?
            //       : const SizedBox(),
            // ),

            /// login widget when login check is false display logo
            loginCheck
                ? LoginScreen()
                : AnimatedPositioned(
                    duration: const Duration(seconds: 5),
                    top: positionCheck ? 20.sp : 100.sp,
                    right: 10.sp,
                    left: 10.sp,
                    bottom: positionCheck ? 0.7.sh : 5.sp,
                    child: AnimatedOpacity(
                      duration: const Duration(seconds: 2),
                      opacity: !loginCheck
                          ? 0.0
                          : animateCheck
                              ? 1
                              : 0.00,
                      child: Container(
                        height: 1.sh,
                        width: 1.sw,
                        margin: EdgeInsets.symmetric(
                            horizontal: positionCheck ? 100.sp : 40.sp),
                        child: Center(
                          child: SvgPicture.asset(
                            Images.logo,
                          ),
                        ),
                      ),
                    ),
                  ),

            /// logo
            AnimatedPositioned(
              duration: const Duration(seconds: 2),
              top: positionCheck ? 20.sp : 100.sp,
              right: 10.sp,
              left: 10.sp,
              bottom: positionCheck ? 0.7.sh : 5.sp,
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: animateCheck ? 1 : 0.03,
                child: Container(
                  height: 1.sh,
                  width: 1.sw,
                  margin: EdgeInsets.symmetric(
                      horizontal: positionCheck ? 100.sp : 40.sp),
                  child: Center(
                    child: SvgPicture.asset(
                      Images.logo,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 20.sp,
              child: positionCheck
                  ? SizedBox(
                      height: 40.sp,
                      width: 1.sw,
                      child: Row(
                        children: [
                          const Spacer(
                            flex: 4,
                          ),
                          Expanded(
                            flex: 3,
                            child: AuthenticationLanguageDropDownButton(
                              context: context,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
