import 'dart:async';

import 'package:app/config/Socket/socket.dart';
import 'package:app/config/device/location_permission.dart';
import 'package:app/config/map/map_constants.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/home/model/coupon_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_estimate_request_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_estimate_result_model.dart'
    hide Location;
import 'package:app/screens/home/model/get_due_payment_model.dart';
import 'package:app/screens/home/model/near_by_driver_model.dart' hide Location;
import 'package:app/screens/home/model/ride_accepted_socket_model.dart'
    hide Location;
import 'package:app/screens/home/model/ride_create_model/ride_request_model.dart';
import 'package:app/screens/home/model/ride_create_model/ride_response_model.dart'
    hide RideLocation;
import 'package:app/screens/home/model/socket_model/reached_destination_socket.dart'
    hide Location;
import 'package:app/screens/home/respository/home_repository.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum HomeFlow {
  searchDestination,
  selectRide,
  waitingDriver,
  accepted,
  driverArrived,
  rideStarted,
  reachedDestination,
  rideCompleted,
}

class HomeProvider extends ChangeNotifier {
  TextEditingController desinationController = TextEditingController();
  final HomeRepository homeRepository = HomeRepository();
  final LocationService _locationService = LocationService();

  PolylinePoints polylinePoints = PolylinePoints(apiKey: MapConstants.mapkey);

  RideEstimateResultModel? _allEstemiateREsult;
  final List<VehicleFare> _allVehicleFare = [];
  RideAcceptedSocketModel? confiremRideDetails;
  bool driverArrivedPopupShown = false;
  bool userReached = false;
  bool userRideComplete = false;

  String vehicleType = "";
  String selectedPayment = "Cash";
  GetDuePaymentModel? _duePayment;
  double selectedVehiclePrice=0.0;
  // ReachedDestinationSocket? _reachedDestinationSocket;

  RideEstimateResultModel? get allEstimatedResult => _allEstemiateREsult;
  List<VehicleFare> get allVehicleFares => _allVehicleFare;

  GetDuePaymentModel? get duePayment => _duePayment;
  // ReachedDestinationSocket? get reachedDestinationSocket=>_reachedDestinationSocket;

  Position? position;

  Future<void> initLocation() async {
    position = await _locationService.checkAndFetchLocation();
    await nearByAvailbeDrvier();
    notifyListeners();
  }

  HomeFlow _flow = HomeFlow.searchDestination;
  HomeFlow get flow => _flow;

  void goToRideSelection() {
    debugPrint("floe id now : $_flow");
    _flow = HomeFlow.selectRide;

    debugPrint("floe id now : $_flow");
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

  void setRideStatus() {
    debugPrint("driver arrived:");
    _flow = HomeFlow.driverArrived;
    notifyListeners();
  }

  void rideStarted() {
    _flow = HomeFlow.rideStarted;
    notifyListeners();
  }

  void reachedDestination() {
    _flow = HomeFlow.reachedDestination;
    notifyListeners();
  }

  void updatePaymeentmode(String value) {
    selectedPayment = value;
    notifyListeners();
  }

  void joinRoom(String rideId) {
    debugPrint("join rooom");
    SocketService().joinRoom(rideId);
  }

  void sendMessages(String rideId, String message) {
    debugPrint("join rooom");
    SocketService().sendMessage(rideId, message);
  }

  //  void rideCompleted() {
  //   _flow = HomeFlow.searchDestination;

  //   notifyListeners();
  // }

  void showRatingSheet() {
    _flow = HomeFlow.rideCompleted;
    notifyListeners();
  }
  //----------------------------------Map created---------------------------------------------



 
  // ================= ROUTE DRAW =================

  Future<void> onRideAccepted(RideAcceptedSocketModel data) async {
    confiremRideDetails = data;
    _flow = HomeFlow.accepted;
    debugPrint("🔄 Flow changed to ACCEPTED");
    debugPrint("Data is : $confiremRideDetails");

    notifyListeners();
  }

  Future<void> onReachedAtDestination(ReachedDestinationSocket data) async {
    debugPrint("🧠 Provider received rideAccepted event");
    debugPrint("📍 Pickup: ${data.finalFare}");

    // confiremRideDetails = data;
    debugPrint("Data is : $data");

    _flow = HomeFlow.reachedDestination;
    debugPrint("🔄 Flow changed to ACCEPTED");

    notifyListeners();
  }

  //----------------------------------Estimate API Call---------------------------------------

  bool loading = false;

  Future<ApiResponse> getAllEstimtedData({
    required String pickupAddress,
    required double pickupLat,
    required double pickupLng,
    required String dropAddress,
    required double dropLat,
    required double dropLng,
  }) async {
    print(
      "location lat and long :$pickupAddress $pickupLat $pickupLng $dropAddress $dropLat $dropLng",
    );
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.totalEstimateRide(
        RideEstimateRequestModel(
          pickupLocation: RideLocation(
            longitude: 75.8270,
            latitude: 26.9240,
            address: "Sindhi Camp bus stop , Jaipur ",
          ),
          dropLocation: RideLocation(
            longitude: 75.8270,
            latitude: 26.9240,
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

      return ApiResponse(
        success: response.success,
        message: response.message,
        data: response.data,
      );
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

  Future<ApiResponse<RideCreatedResposeModel>> createRide(String id) async {
    // debugPrint(
    //   "ride id : $id ${position!.latitude}. ....${position!.longitude} $vehicleType. ${selectedPayment.toString().toLowerCase()}",
    // );
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.rideCreated(
        RideCreatedRequestModel(
          pickupLocation: Location(coordinates: [75.8270, 26.9240]),
          dropLocation: Location(coordinates: [75.8260, 26.9250]),
          vehicleType: vehicleType,
          paymentMethod: selectedPayment.toString().toLowerCase(),
        ),
        id,
      );

      loading = false;

     
      return response;
      // return ApiResponse(success: response.success, message: response.message);
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
        reason: reason,
      );

      loading = false;
      notifyListeners();

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

  //----------------------------------------Apply Coupon -------------------------------------------

  bool isCouponApplied = false;
  int? discountPercent;
  String? discountType;

  CouponModel? coupnResponse;

  Future<ApiResponse> applyCoupon(
    String couponCode,
    String userId,
    String rideId,
  ) async {
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.applyCoupon(
        couponCode,
        userId,
        rideId,
      );
      if (response.data != null) {
        discountPercent = response.data!.discount!.discountValue;
        discountType = response.data!.discount!.discountType;

        couponCode = response.data!.discount!.code!;
      }

      loading = false;
      notifyListeners();
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

  double getDiscountedFare(double originalFare) {
    if (!isCouponApplied || discountPercent == null) {
      return originalFare;
    }

    final discountAmount = originalFare * (discountPercent! / 100);

    return originalFare - discountAmount;
  }

  //----------------------------------------Scheduled Ride -------------------------------------------

  Future<ApiResponse> scheduledRide(
    String? promoCode,
    vehicleType,
    String paymentMethod,
    String scheduledTime,
  ) async {
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.scheduledRide(
        promoCode!,
        vehicleType,
        paymentMethod,
        scheduledTime,
      );
      if (response.data != null) {}

      loading = false;
      notifyListeners();
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

  //----------------------------------------Get Due Payment  -------------------------------------------

  Future<ApiResponse> getDuePayment(String rideId) async {
    loading = true;
    notifyListeners();

    debugPrint("ride id : $rideId");
    try {
      final response = await homeRepository.getDuePayemnt(rideId);
      if (response.data != null) {
        _duePayment = response.data;
      }

      loading = false;
      notifyListeners();
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

  //----------------------------------------  Payment Done  -------------------------------------------

  Future<ApiResponse> payemntDone(String rideId) async {
    loading = true;
    notifyListeners();

    debugPrint("ride id : $rideId");
    try {
      final response = await homeRepository.paymentDone(rideId);
      loading = false;
      notifyListeners();
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

  //----------------------------------------  Rating -------------------------------------------

  Future<ApiResponse> rating(
    String rideId,
    String rating,
    String feedback,
  ) async {
    loading = true;
    notifyListeners();

    debugPrint("ride id : $rideId");
    try {
      final response = await homeRepository.rating(rideId, rating, feedback);
      loading = false;
      notifyListeners();
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

  //----------------------------------------  near by driver  -------------------------------------------

  Future<ApiResponse<NearByDriverModel>> nearByAvailbeDrvier() async {
    loading = true;
    notifyListeners();

    debugPrint("inside nearby driver : ");
    try {
      final response = await homeRepository.nearByVehicle(
        position?.latitude.toString() ?? "0.0",
        position?.longitude.toString() ?? "0.0",
      );

      if (response.success) {
        debugPrint("response is : ${response.data}");
      }
      loading = false;
      notifyListeners();
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
