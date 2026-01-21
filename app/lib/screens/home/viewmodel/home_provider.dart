import 'package:app/config/device/location_permission.dart';
import 'package:app/config/map/map_constants.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_estimate_request_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_estimate_result_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/vehicle_fare_model.dart';
import 'package:app/screens/home/model/ride_create_model/ride_request_model.dart';
import 'package:app/screens/home/respository/home_repository.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum HomeFlow { searchDestination, selectRide, waitingDriver, accepted }

class HomeProvider extends ChangeNotifier {
  final HomeRepository homeRepository = HomeRepository();
  final LocationService _locationService = LocationService();

  PolylinePoints polylinePoints = PolylinePoints(apiKey: MapConstants.mapkey);

  RideEstimateResultModel? _allEstemiateREsult;
  final List<VehicleFare> _allVehicleFare = [];
  dynamic confiremRideDetails;

  String vehicleType = "";

  RideEstimateResultModel? get allEstimatedResult => _allEstemiateREsult;
  List<VehicleFare> get allVehicleFares => _allVehicleFare;

  Position? position;

  Future<void> initLocation() async {
    position = await _locationService.checkAndFetchLocation();
    notifyListeners();
  }

  HomeFlow _flow = HomeFlow.searchDestination;
  HomeFlow get flow => _flow;

  void goToRideSelection() {
    _flow = HomeFlow.selectRide;
    notifyListeners();
  }

  void goBackToSearch() {
    _flow = HomeFlow.searchDestination;
    notifyListeners();
  }

  void goToWaiting() {
    _flow = HomeFlow.waitingDriver;

    notifyListeners();
  }

  void goToRideConfirmed() {
    _flow = HomeFlow.accepted;
    notifyListeners();
  }

  //----------------------------------Map created---------------------------------------------

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  Set<Marker> get markers => _markers;
  Set<Polyline> get polylines => _polylines;
  GoogleMapController? _mapController;

  void onMapCreated(GoogleMapController mapController) {
    _mapController = mapController;

    print(
      "location lat and long : ${position!.latitude} ${position!.longitude}",
    );

    // If location already exists, move camera
    if (position != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _addUserMarker(); // Add marker first
        _moveCameraToUser(); // Then move camera
      });
    }
    notifyListeners();
  }

  void _moveCameraToUser() {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position!.latitude, position!.longitude),
          zoom: 12,
          tilt: 45,
        ),
      ),
    );
  }

  void _addUserMarker() {
    if (position == null) return;

    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('user'),
        position: LatLng(position!.latitude, position!.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
    notifyListeners();
  }
  // ================= ROUTE DRAW =================

  Future<void> onRideAccepted(dynamic ride) async {
    debugPrint("🧠 Provider received rideAccepted event");
    debugPrint("📍 Pickup: ${ride['pickupLocation']}");
    debugPrint("📍 Drop: ${ride['dropLocation']}");
    confiremRideDetails = ride;
    await _drawRouteFromRide(ride);

    _flow = HomeFlow.accepted;
    debugPrint("🔄 Flow changed to ACCEPTED");

    notifyListeners();
  }

  Future<void> _drawRouteFromRide(dynamic ride) async {
    final pickupCoords = ride['pickupLocation']['coordinates'];
    final dropCoords = ride['dropLocation']['coordinates'];

    // ✅ CORRECT ORDER
    final pickup = LatLng(pickupCoords[0], pickupCoords[1]);
    final drop = LatLng(dropCoords[0], dropCoords[1]);

    debugPrint("🛣 Drawing route");
    debugPrint("➡ Pickup: $pickup");
    debugPrint("➡ Drop: $drop");

    final result = await polylinePoints.getRouteBetweenCoordinatesV2(
      request: RoutesApiRequest(
        origin: PointLatLng(pickup.latitude, pickup.longitude),
        destination: PointLatLng(drop.latitude, drop.longitude),
        travelMode: TravelMode.driving,
      ),
    );

    if (result.routes.isEmpty) {
      debugPrint("❌ Google returned no routes");
      return;
    }

    final points = result.routes.first.polylinePoints!;
    debugPrint("✅ Polyline points count: ${points.length}");

    _polylines.clear();

    _polylines.add(
      Polyline(
        polylineId: const PolylineId('ride_route'),
        color: Colors.green,
        width: 6,
        points: points.map((p) => LatLng(p.latitude, p.longitude)).toList(),
      ),
    );

    notifyListeners();
  }

  // void _fitRouteBounds(List<LatLng> points) {
  //   final bounds = LatLngBounds(
  //     southwest: LatLng(
  //       points.map((e) => e.latitude).reduce((a, b) => a < b ? a : b),
  //       points.map((e) => e.longitude).reduce((a, b) => a < b ? a : b),
  //     ),
  //     northeast: LatLng(
  //       points.map((e) => e.latitude).reduce((a, b) => a > b ? a : b),
  //       points.map((e) => e.longitude).reduce((a, b) => a > b ? a : b),
  //     ),
  //   );

  //   _mapController?.animateCamera(
  //     CameraUpdate.newLatLngBounds(bounds, 80),
  //   );
  // }

  //----------------------------------Estimate API Call---------------------------------------

  bool loading = false;

  Future<ApiResponse> getAllEstimtedData() async {
    print(
      "location lat and long : ${position!.latitude} ${position!.longitude}",
    );
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.totalEstimateRide(
        RideEstimateRequestModel(
          pickupLocation: RideLocation(
            latitude: 26.9240,
            longitude: 75.8270,
            address: "Sindhi Camp bus stop , Jaipur ",
          ),
          dropLocation: RideLocation(
            latitude: 26.9250,
            longitude: 75.8260,
            address: " Malvie Nagar , Sector-5 Jaipur",
          ),
        ),
      );

      loading = false;

      if (response.data == null) {
        return ApiResponse(
          success: response.success,
          message: response.message,
        );
      }

      _allEstemiateREsult = response.data;
      _allVehicleFare
        ..clear()
        ..addAll(response.data!.allVehicleFares);

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;

      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Something went wrong  ${e.toString()}",
      );
    }
  }

  //--------------------------------------Ride Create --------------------------------

  Future<ApiResponse> createRide(String id) async {
    debugPrint(
      "ride id : $id ${position!.latitude}. ....${position!.longitude} $vehicleType",
    );
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.rideCreated(
        RideCreatedRequestModel(
          pickupLocation: Location(coordinates: [26.9240, 75.8270]),
          dropLocation: Location(coordinates: [26.9250, 75.8260]),
          vehicleType: "mini",
          paymentMethod: "cash",
        ),
        id,
      );

      loading = false;

      debugPrint(
        "Data : ${response.data} ${response.message} ${response.success}",
      );

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;
      debugPrint("error : ${e.toString()}");
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Something went wrong  ${e.toString()}",
      );
    }
  }

  //----------------------------------------Cancel the ride--------------------------------------

  Future<ApiResponse> cancelRide(String rideId, String reason) async {
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.rideCancel(
        rideId: rideId,
        reason:reason,
      );

      loading = false;

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;
      debugPrint("error : ${e.toString()}");
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Something went wrong  ${e.toString()}",
      );
    }
  }
}

// Hawa Mahal (approx. 26.9240° N, 75.8270° E) and Jantar Mantar (approx. 26.9250° N, 75.8260° E)
