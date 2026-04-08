import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapConstants {
  static final mapkey = "AIzaSyBEfghVDiDqUu2WgFmbDovafENRA2lMObQ";
}

class MapRouteService {
  static const String apiKey = "AIzaSyBEfghVDiDqUu2WgFmbDovafENRA2lMObQ";

  static Future<List<LatLng>> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final url = "https://routes.googleapis.com/directions/v2:computeRoutes";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": apiKey,

        /// IMPORTANT (without this response is empty)
        "X-Goog-FieldMask": "routes.polyline.encodedPolyline",
      },
      body: jsonEncode({
        "origin": {
          "location": {
            "latLng": {
              "latitude": origin.latitude,
              "longitude": origin.longitude,
            },
          },
        },
        "destination": {
          "location": {
            "latLng": {
              "latitude": destination.latitude,
              "longitude": destination.longitude,
            },
          },
        },
        "travelMode": "DRIVE",
      }),
    );

    debugPrint("STATUS CODE: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    final data = jsonDecode(response.body);

    if (data["routes"] == null || data["routes"].isEmpty) {
      return [];
    }

    final encodedPolyline = data["routes"][0]["polyline"]["encodedPolyline"];

    /// Decode Polylinep
    List<PointLatLng> result = PolylinePoints.decodePolyline(encodedPolyline);

    return result
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
  }
}
