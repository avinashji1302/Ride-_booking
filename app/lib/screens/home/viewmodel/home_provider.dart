import 'package:app/config/Socket/socket.dart';
import 'package:app/config/device/location_permission.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_estimate_request_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_estimate_result_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/vehicle_fare_model.dart';
import 'package:app/screens/home/model/ride_create_model/ride_request_model.dart';
import 'package:app/screens/home/respository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum HomeFlow {
  searchDestination,
  selectRide,
  waitingDriver,
  rideConfirmed,
}


class HomeProvider extends ChangeNotifier {
  final HomeRepository homeRepository = HomeRepository();
  final LocationService _locationService = LocationService();

  RideEstimateResultModel? _allEstemiateREsult;
  final List<VehicleFare> _allVehicleFare = [];

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
  _flow = HomeFlow.rideConfirmed;
  notifyListeners();
}



  //----------------------------------Map created---------------------------------------------

  GoogleMapController? _controller;

  Set<Marker> marker = {};

  void onMapCreated(GoogleMapController mapController) {
    _controller = mapController;

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
    _controller?.animateCamera(
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
    marker = {
      Marker(
        markerId: const MarkerId("user_location"),
        position: LatLng(position!.latitude, position!.longitude),
        infoWindow: const InfoWindow(title: "Your Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure, // ✅ Blue color to stand out
        ),
      ),
    };

    notifyListeners();
  }





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
          vehicleType:  "mini" ,
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
}


// Hawa Mahal (approx. 26.9240° N, 75.8270° E) and Jantar Mantar (approx. 26.9250° N, 75.8260° E)