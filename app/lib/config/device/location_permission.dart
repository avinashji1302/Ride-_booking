// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:latlong2/latlong.dart';

// class LocationService {
//   Position? position;

//   Future<Position?> checkAndFetchLocation() async {
//     // 1️⃣ Check GPS
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       debugPrint("Location service is OFF");
//       return null;
//     }

//     // 2️⃣ Check permission (THIS is geolocator enum)
//     LocationPermission permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         debugPrint("Permission denied");
//         return null;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       debugPrint("Permission denied forever");
//       return null;
//     }

//     // 3️⃣ Get location
//     position = await Geolocator.getCurrentPosition(
//       locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
//     );

//     debugPrint(
//       "Location fetched: ${position!.latitude}, ${position!.longitude}",
//     );

//     return position;
//   }

//   //----------------- Converting latlang to Address------------------

//   Future<String> fromLatLongAddress(LatLng latlong) async {
//     if (latlong != null) {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         latlong.latitude,
//         latlong.longitude,
//       );

//       final place = placemarks.first;

//       /// ⭐ Uber style short address
//       // currentAddress = "${place.name}, ${place.subLocality}, ${place.locality}";

//       debugPrint("${place.name}, ${place.subLocality}, ${place.locality}");

//       return "${place.name}, ${place.subLocality}, ${place.locality}";
//     }
//   }

//   // Future<List<LocationSearchModel>> searchLocation(String query) async {
//   //   if (query.isEmpty) return [];

//   //   final url =
//   //       "https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5";

//   //   final response = await http.get(
//   //     Uri.parse(url),
//   //     headers: {"User-Agent": "com.waplia.rideapp"},
//   //   );

//   //   final data = jsonDecode(response.body);

//   //   debugPrint("Location response : ${data} ${response.body}");

//   //   return (data as List).map((e) => LocationSearchModel.fromJson(e)).toList();
//   // }

//   Future<List<LocationSearchModel>> searchLocation(String query) async {
//     if (query.isEmpty) return [];

//     final url =
//         "https://nominatim.openstreetmap.org/search"
//         "?q=$query"
//         "&format=json"
//         "&addressdetails=1"
//         "&limit=5"
//         "&countrycodes=in"
//         "&viewbox=75.5,27.1,76.0,26.7"
//         "&bounded=1";

//     final response = await http.get(
//       Uri.parse(url),
//       headers: {"User-Agent": "com.waplia.rideapp", "Accept-Language": "en-IN"},
//     );

//     final data = jsonDecode(response.body);

//     return (data as List).map((e) => LocationSearchModel.fromJson(e)).toList();
//   }

//   //------------------------------------------- getting route points----------------------------------------

//   Future<List<LatLng>> getRoute({
//     required LatLng pickup,
//     required LatLng destination,
//   }) async {
//     final url =
//         "https://router.project-osrm.org/route/v1/driving/"
//         "${pickup.longitude},${pickup.latitude};"
//         "${destination.longitude},${destination.latitude}"
//         "?overview=full&geometries=geojson";

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode != 200) {
//       throw Exception("Route not found");
//     }

//     final data = jsonDecode(response.body);

//     final coordinates = data['routes'][0]['geometry']['coordinates'];

//     List<LatLng> routePoints = [];

//     for (var coord in coordinates) {
//       routePoints.add(LatLng(coord[1], coord[0]));
//     }

//     return routePoints;
//   }
// }

// class LocationSearchModel {
//   final String displayName;
//   final double lat;
//   final double lon;

//   LocationSearchModel({
//     required this.displayName,
//     required this.lat,
//     required this.lon,
//   });

//   factory LocationSearchModel.fromJson(Map<String, dynamic> json) {
//     return LocationSearchModel(
//       displayName: json['display_name'],
//       lat: double.parse(json['lat']),
//       lon: double.parse(json['lon']),
//     );
//   }
// }



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ADD to pubspec: shared_preferences

class LocationService {
  Position? position;

  // ✅ FIX: Cache key for recent searches stored locally
  static const String _recentKey = 'recent_searches';

  Future<Position?> checkAndFetchLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location service is OFF");
      return null;
    }

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

    position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    debugPrint(
      "Location fetched: ${position!.latitude}, ${position!.longitude}",
    );

    return position;
  }

  // ✅ UNCHANGED: reverse geocoding
  Future<String> fromLatLongAddress(LatLng latlong) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latlong.latitude,
      latlong.longitude,
    );

    final place = placemarks.first;

    debugPrint("${place.name}, ${place.subLocality}, ${place.locality}");

    return "${place.name}, ${place.subLocality}, ${place.locality}";
  }

  // ✅ FIX: Reduced debounce to 300ms in provider + limit=8 for more results
  // ✅ NEW: Pass user's current lat/lng for proximity bias (shows nearby results first)
  Future<List<LocationSearchModel>> searchLocation(
    String query, {
    double? nearLat, // 🆕 current user location for proximity ranking
    double? nearLng,
  }) async {
    if (query.isEmpty) return [];

    // Build viewbox around user's location if available (±0.3 degrees ≈ 30km)
    String viewboxParam = "&viewbox=75.5,27.1,76.0,26.7&bounded=0";
    if (nearLat != null && nearLng != null) {
      // ✅ FIX: Dynamic viewbox around user instead of hardcoded Jaipur coords
      final latMin = nearLat - 0.3;
      final latMax = nearLat + 0.3;
      final lngMin = nearLng - 0.3;
      final lngMax = nearLng + 0.3;
      viewboxParam = "&viewbox=$lngMin,$latMax,$lngMax,$latMin&bounded=0";
    }

    final url =
        "https://nominatim.openstreetmap.org/search"
        "?q=${Uri.encodeComponent(query)}" // ✅ FIX: encode query (handles spaces/special chars)
        "&format=json"
        "&addressdetails=1"
        "&limit=8" // ✅ FIX: increased from 5 → 8
        "&countrycodes=in"
        "$viewboxParam";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "User-Agent": "com.waplia.rideapp",
          "Accept-Language": "en-IN",
        },
      ).timeout(const Duration(seconds: 8)); // ✅ FIX: add timeout

      if (response.statusCode != 200) return [];

      final data = jsonDecode(response.body);

      return (data as List)
          .map((e) => LocationSearchModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("Search error: $e");
      return [];
    }
  }

  // ✅ NEW: Save a searched/selected place to recent history
  Future<void> saveRecentSearch(LocationSearchModel place) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_recentKey) ?? [];

    final encoded = jsonEncode({
      'displayName': place.displayName,
      'lat': place.lat,
      'lon': place.lon,
    });

    // Remove duplicate if already saved
    existing.removeWhere((e) {
      final decoded = jsonDecode(e);
      return decoded['displayName'] == place.displayName;
    });

    existing.insert(0, encoded); // most recent first

    // Keep only last 5 recent searches
    final trimmed = existing.take(5).toList();
    await prefs.setStringList(_recentKey, trimmed);
  }

  // ✅ NEW: Load recent search history
  Future<List<LocationSearchModel>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_recentKey) ?? [];

    return stored.map((e) {
      final decoded = jsonDecode(e);
      return LocationSearchModel(
        displayName: decoded['displayName'],
        lat: decoded['lat'],
        lon: decoded['lon'],
        isRecent: true, // 🆕 flag for UI to show history icon
      );
    }).toList();
  }

  Future<List<LatLng>> getRoute({
    required LatLng pickup,
    required LatLng destination,
  }) async {
    final url =
        "https://router.project-osrm.org/route/v1/driving/"
        "${pickup.longitude},${pickup.latitude};"
        "${destination.longitude},${destination.latitude}"
        "?overview=full&geometries=geojson";

    try {
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode != 200) {
        throw Exception("Route not found");
      }

      final data = jsonDecode(response.body);
      final coordinates = data['routes'][0]['geometry']['coordinates'];

      return (coordinates as List)
          .map((coord) => LatLng(coord[1] as double, coord[0] as double))
          .toList();
    } catch (e) {
      debugPrint("Route error: $e");
      return [];
    }
  }
}

class LocationSearchModel {
  final String displayName;
  final double lat;
  final double lon;
  final bool isRecent; // ✅ NEW: to distinguish recent vs live results in UI

  LocationSearchModel({
    required this.displayName,
    required this.lat,
    required this.lon,
    this.isRecent = false,
  });

  factory LocationSearchModel.fromJson(Map<String, dynamic> json) {
    return LocationSearchModel(
      displayName: json['display_name'],
      lat: double.parse(json['lat'].toString()),
      lon: double.parse(json['lon'].toString()),
    );
  }
}