import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerData {
  final String id;
  final LatLng position;
  int priority;

  MarkerData(
      {required this.id, required this.position, required this.priority});
}
