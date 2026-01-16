import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/home/model/ride_estimate_request_model.dart';
import 'package:app/screens/home/model/ride_estimate_result_model.dart';
import 'package:app/screens/home/model/vehicle_fare_model.dart';
import 'package:app/screens/home/respository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

enum HomeFlow { searchDestination, selectRide }

class HomeProvider extends ChangeNotifier {
  final HomeRepository homeRepository = HomeRepository();
 final  List<RideEstimateResultModel> _allEstemiateREsult = [];
 final List<VehicleFare> _allVehicleFare = [];

  List<RideEstimateResultModel> get allEstimatedResult => _allEstemiateREsult;
  List<VehicleFare> get allVehicleFares => _allVehicleFare;

  Position? position;

  Future<void> permisson() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    debugPrint("chekc permsoim : $permission");

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("User denied the permisoon");
      } else {
        position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
        );
        debugPrint(
          "location is : ${position!.altitude} ${position!.longitude}",
        );
      }
    } else {
      position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      debugPrint(
        "location  else is : ${position!.altitude} ${position!.longitude}",
      );
    }

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

  //----------------------------------Estimate API Call---------------------------------------

  bool loading = false;

  Future<ApiResponse> getAllEstimtedData() async {
    print(
      "location lat and long : ${position!.latitude} ${position!.longitude}",
    );
    loading = true;
    ChangeNotifier();

    try {
      final response = await homeRepository.totalEstimateRide(
        RideEstimateRequestModel(
          pickupLocation: RideLocation(
            latitude: position!.latitude,
            longitude: position!.longitude,
            address: "Sindhi Camp bus stop , Jaipur ",
          ),
          dropLocation: RideLocation(
            latitude: 77.209,
            longitude: 28.6139,
            address: " Malvie Nagar , Sector-5 Jaipur",
          ),
        ),
      );

      loading = false;

      if (response.data != null) {
        _allEstemiateREsult.add(response.data!);
        _allVehicleFare.addAll(response.data!.allVehicleFares);
      }

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;

      notifyListeners();

      return ApiResponse(success: false, message: "Something went wrong ");
    }
  }
}
