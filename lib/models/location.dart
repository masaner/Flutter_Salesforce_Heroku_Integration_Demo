// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';

class Location {
  late double lat, lon;

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      lon = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
