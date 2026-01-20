import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Position? position;

  Future<Position?> checkAndFetchLocation() async {
    // 1️⃣ Check GPS
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location service is OFF");
      return null;
    }

    // 2️⃣ Check permission (THIS is geolocator enum)
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Permission denied");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Permission denied forever");
      return null;
    }

    // 3️⃣ Get location
    position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    debugPrint(
      "Location fetched: ${position!.latitude}, ${position!.longitude}",
    );

    return position;
  }
}
