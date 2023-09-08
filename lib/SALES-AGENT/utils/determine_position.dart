import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

Future<void> determinePosition(ValueNotifier location) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (serviceEnabled) {
    location.value = await Geolocator.getCurrentPosition();
    return;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  location.value = await Geolocator.getCurrentPosition();
}
