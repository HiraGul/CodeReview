import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/orders_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/colors.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/strings.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool? serviceEnabled;
  LocationPermission? permission;
  _determinePosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      permission = await Geolocator.requestPermission();
    } else {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        Geolocator.openLocationSettings();
      } else {
        _getCurrentPosition();
        if (context.mounted) {
          Navigator.pushNamed(context, Strings.splashScreen);
        }
      }
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
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20.sp),
          children: [
            Icon(
              Icons.location_off_sharp,
              color: AppColors.brightRedColor,
              size: 100.sp,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Center(
              child: Text(
                "Please Allow Location Service To Proceed".tr(),
                style: GoogleFonts.openSans(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor),
              ),
            ),
            SizedBox(
              height: 40.sp,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.sp),
              child: ElevatedButton(
                onPressed: () {
                  _determinePosition();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.normal),
                ),
                child: Text("Retry".tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
