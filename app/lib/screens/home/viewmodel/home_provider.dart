import 'dart:async';

import 'package:app/config/Socket/socket.dart';
import 'package:app/config/device/location_permission.dart';

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
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart' hide Location;

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

// enum HomeFlow {
//   searchDestination,
//   selectRide,
//   waitingDriver,
//   accepted,
//   driverArrived,
//   rideStarted,
//   reachedDestination,
//   rideCompleted,
// }

// class HomeProvider extends ChangeNotifier {
//   TextEditingController desinationController = TextEditingController();
//   final HomeRepository homeRepository = HomeRepository();
//   final LocationService _locationService = LocationService();

//   RideEstimateResultModel? _allEstemiateREsult;
//   final List<VehicleFare> _allVehicleFare = [];
//   RideAcceptedSocketModel? confiremRideDetails;
//   bool driverArrivedPopupShown = false;
//   bool userReached = false;
//   bool userRideComplete = false;

//   String vehicleType = "";
//   String selectedPayment = "Cash";
//   GetDuePaymentModel? _duePayment;
//   double selectedVehiclePrice = 0.0;
//   // ReachedDestinationSocket? _reachedDestinationSocket;

//   RideEstimateResultModel? get allEstimatedResult => _allEstemiateREsult;
//   List<VehicleFare> get allVehicleFares => _allVehicleFare;

//   GetDuePaymentModel? get duePayment => _duePayment;
//   // ReachedDestinationSocket? get reachedDestinationSocket=>_reachedDestinationSocket;
//   final MapController mapController = MapController();
//   StreamSubscription<Position>? _positionStream;

//   Position? position;
//   LatLng? pickupLocation;
//   LatLng? destinationLocation;
//   String pickupAddress = "";

//   List<LatLng> routePoints = [];

//   Future<void> initLocation() async {
//     position = await _locationService.checkAndFetchLocation();

//     if (position != null) {
//       pickupLocation = LatLng(position!.latitude, position!.longitude);

//       mapController.move(pickupLocation!, 16);
//     }

//     _startLiveLocation();
//     await fromLatLongAddress();

//     notifyListeners();
//   }

//   HomeFlow _flow = HomeFlow.searchDestination;
//   HomeFlow get flow => _flow;

//   //----------------------------------------------------------------------------map-------------------

//   //start lisrening movment --------------

//   void _startLiveLocation() {
//     const locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 5,
//     );

//     _positionStream =
//         Geolocator.getPositionStream(locationSettings: locationSettings).listen(
//           (Position pos) {
//             pickupLocation = LatLng(pos.latitude, pos.longitude);

//             mapController.move(pickupLocation!, 16);

//             notifyListeners();
//           },
//         );
//   }

//   Future<void> onMapMoved(LatLng? center) async {
//     if (center == null) return;

//     pickupLocation = center;

//     pickupAddress = await _locationService.fromLatLongAddress(center);

//     debugPrint("picupaddress on change.....: $pickupAddress");
//   }

//   Future<void> fromLatLongAddress() async {
//     if (position != null) {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position!.latitude,
//         position!.longitude,
//       );

//       final place = placemarks.first;

//       /// ⭐ Uber style short address
//       pickupAddress = "${place.name}, ${place.subLocality}, ${place.locality}";

//       notifyListeners();
//       debugPrint("laddress is : plaxwm.... $pickupAddress");
//     }
//   }

//   List<LocationSearchModel> destinationSuggestions = [];
//   Timer? _debounce;

//   void searchDestination(String value) {
//     if (_debounce?.isActive ?? false) {
//       _debounce!.cancel();
//     }

//     _debounce = Timer(const Duration(milliseconds: 600), () async {
//       if (value.isEmpty) {
//         destinationSuggestions.clear();
//         destinationSuggestions.add(
//           LocationSearchModel(
//             displayName: "Sindhi Camp bus stop , Jaipur ",
//             lat: 26.9240,
//             lon: 75.8270,
//           ),
//         );
//         notifyListeners();
//         return;
//       }

//       debugPrint("Searching: $value");

//       destinationSuggestions = await _locationService.searchLocation(value);

//       notifyListeners();
//     });
//   }

//   ///--------------------------- SELECT DESTINATION--------------------------------------------

//   void selectDestination(LocationSearchModel place) {
//     destinationLocation = LatLng(place.lat, place.lon);

//     desinationController.text = place.displayName;

//     destinationSuggestions.clear();

//     notifyListeners();
//   }

//   //----------------------------------Draw Route-----------------------------------------------

//   Future<void> drawRoute() async {
//     if (pickupLocation == null || destinationLocation == null) return;

//     routePoints = await _locationService.getRoute(
//       pickup: pickupLocation!,
//       destination: destinationLocation!,
//     );

//     _fitCameraToRoute();

//     notifyListeners();
//   }

//   void _fitCameraToRoute() {
//     if (routePoints.isEmpty) return;

//     double minLat = routePoints.first.latitude;
//     double maxLat = routePoints.first.latitude;
//     double minLng = routePoints.first.longitude;
//     double maxLng = routePoints.first.longitude;

//     for (final p in routePoints) {
//       minLat = p.latitude < minLat ? p.latitude : minLat;
//       maxLat = p.latitude > maxLat ? p.latitude : maxLat;
//       minLng = p.longitude < minLng ? p.longitude : minLng;
//       maxLng = p.longitude > maxLng ? p.longitude : maxLng;
//     }

//     final bounds = LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng));

//     mapController.fitCamera(
//       CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(80)),
//     );
//   }

//   @override
//   void dispose() {
//     _positionStream?.cancel();
//     super.dispose();
//   }

//   //---------------------------------------------------------

//   void goToRideSelection() {
//     debugPrint("floe id now : $_flow");
//     _flow = HomeFlow.selectRide;

//     debugPrint("floe id now : $_flow");
//     notifyListeners();
//   }

//   void goBackToSearch() {
//     _flow = HomeFlow.searchDestination;
//     notifyListeners();
//   }

//   void goToWaiting() {
//     _flow = HomeFlow.waitingDriver;

//     notifyListeners();
//   }

//   void goToRideConfirmed() {
//     _flow = HomeFlow.accepted;
//     notifyListeners();
//   }

//   void setRideStatus() {
//     debugPrint("driver arrived:");
//     _flow = HomeFlow.driverArrived;
//     notifyListeners();
//   }

//   void rideStarted() {
//     _flow = HomeFlow.rideStarted;
//     notifyListeners();
//   }

//   void reachedDestination() {
//     _flow = HomeFlow.reachedDestination;
//     notifyListeners();
//   }

//   void updatePaymeentmode(String value) {
//     selectedPayment = value;
//     notifyListeners();
//   }

//   void joinRoom(String rideId) {
//     debugPrint("join rooom");
//     SocketService().joinRoom(rideId);
//   }

//   void sendMessages(String rideId, String message) {
//     debugPrint("join rooom");
//     SocketService().sendMessage(rideId, message);
//   }

//   //  void rideCompleted() {
//   //   _flow = HomeFlow.searchDestination;

//   //   notifyListeners();
//   // }

//   void showRatingSheet() {
//     _flow = HomeFlow.rideCompleted;
//     notifyListeners();
//   }
//   //----------------------------------Map created---------------------------------------------

//   Future<void> onRideAccepted(RideAcceptedSocketModel data) async {
//     confiremRideDetails = data;
//     _flow = HomeFlow.accepted;
//     debugPrint("🔄 Flow changed to ACCEPTED");
//     debugPrint("Data is : $confiremRideDetails");

//     notifyListeners();
//   }

//   Future<void> onReachedAtDestination(ReachedDestinationSocket data) async {
//     debugPrint("🧠 Provider received rideAccepted event");
//     debugPrint("📍 Pickup: ${data.finalFare}");

//     // confiremRideDetails = data;
//     debugPrint("Data is : $data");

//     _flow = HomeFlow.reachedDestination;
//     debugPrint("🔄 Flow changed to ACCEPTED");

//     notifyListeners();
//   }

//   //----------------------------------Estimate API Call---------------------------------------

//   bool loading = false;

//   Future<ApiResponse> getAllEstimtedData({
//     required String pickupAddress,
//     required double pickupLat,
//     required double pickupLng,
//     required String dropAddress,
//     required double dropLat,
//     required double dropLng,
//   }) async {
//     print(
//       "location lat and long :$pickupAddress $pickupLat $pickupLng $dropAddress $dropLat $dropLng",
//     );
//     loading = true;
//     notifyListeners();

//     try {
//       final response = await homeRepository.totalEstimateRide(
//         RideEstimateRequestModel(
//           pickupLocation: RideLocation(
//             longitude: pickupLng,
//             latitude: pickupLat,
//             address: pickupAddress,
//           ),
//           dropLocation: RideLocation(
//             longitude: dropLng,
//             latitude: dropLat,
//             address: dropAddress,
//           ),
//         ),
//       );

//       loading = false;

//       if (response.data == null) {
//         return ApiResponse(
//           success: response.success,
//           message: response.message,
//         );
//       }

//       _allEstemiateREsult = response.data;
//       _allVehicleFare
//         ..clear()
//         ..addAll(response.data!.allVehicleFares);

//       pickupLocation = LatLng(dropLat, dropLng);
//       destinationLocation = LatLng(pickupLat, pickupLng);
//       await drawRoute();

//       return ApiResponse(
//         success: response.success,
//         message: response.message,
//         data: response.data,
//       );
//     } catch (e) {
//       loading = false;

//       notifyListeners();

//       return ApiResponse(
//         success: false,
//         message: "Something went wrong  ${e.toString()}",
//       );
//     }
//   }

//   //--------------------------------------Ride Create --------------------------------

//   Future<ApiResponse<RideCreatedResposeModel>> createRide(String id) async {
//     // debugPrint(
//     //   "ride id : $id ${position!.latitude}. ....${position!.longitude} $vehicleType. ${selectedPayment.toString().toLowerCase()}",
//     // );
//     loading = true;
//     notifyListeners();

//     try {
//       final response = await homeRepository.rideCreated(
//         RideCreatedRequestModel(
//           pickupLocation: LocationPoints(
//             coordinates: [
//               pickupLocation?.longitude ?? 75.8260,
//               pickupLocation?.latitude ?? 26.9240,
//             ],
//           ),
//           dropLocation: LocationPoints(
//             coordinates: [
//               destinationLocation?.longitude ?? 75.8260,
//               destinationLocation?.latitude ?? 26.9250,
//             ],
//           ),
//           vehicleType: vehicleType,
//           paymentMethod: selectedPayment.toString().toLowerCase(),
//         ),
//         id,
//       );

//       loading = false;

//       // return response;
//       return ApiResponse(success: response.success, message: response.message);
//     } catch (e) {
//       loading = false;
//       debugPrint("error : ${e.toString()}");
//       notifyListeners();

//       return ApiResponse(
//         success: false,
//         message: "Something went wrong  ${e.toString()}",
//       );
//     }
//   }

//   //----------------------------------------Cancel the ride--------------------------------------

//   Future<ApiResponse> cancelRide(String rideId, String reason) async {
//     loading = true;
//     notifyListeners();

//     try {
//       final response = await homeRepository.rideCancel(
//         rideId: rideId,
//         reason: reason,
//       );

//       loading = false;
//       notifyListeners();

//       return ApiResponse(success: response.success, message: response.message);
//     } catch (e) {
//       loading = false;
//       debugPrint("error : ${e.toString()}");
//       notifyListeners();

//       return ApiResponse(
//         success: false,
//         message: "Something went wrong  ${e.toString()}",
//       );
//     }
//   }

//   //----------------------------------------Apply Coupon -------------------------------------------

//   bool isCouponApplied = false;
//   int? discountPercent;
//   String? discountType;

//   CouponModel? coupnResponse;

//   Future<ApiResponse> applyCoupon(
//     String couponCode,
//     String userId,
//     String rideId,
//   ) async {
//     loading = true;
//     notifyListeners();

//     try {
//       final response = await homeRepository.applyCoupon(
//         couponCode,
//         userId,
//         rideId,
//       );
//       if (response.data != null) {
//         discountPercent = response.data!.discount!.discountValue;
//         discountType = response.data!.discount!.discountType;

//         couponCode = response.data!.discount!.code!;
//       }

//       loading = false;
//       notifyListeners();
//       return ApiResponse(success: response.success, message: response.message);
//     } catch (e) {
//       loading = false;
//       debugPrint("error : ${e.toString()}");
//       notifyListeners();

//       return ApiResponse(
//         success: false,
//         message: "Something went wrong  ${e.toString()}",
//       );
//     }
//   }

//   double getDiscountedFare(double originalFare) {
//     if (!isCouponApplied || discountPercent == null) {
//       return originalFare;
//     }

//     final discountAmount = originalFare * (discountPercent! / 100);

//     return originalFare - discountAmount;
//   }

//   //----------------------------------------Scheduled Ride -------------------------------------------

//   Future<ApiResponse> scheduledRide(
//     String? promoCode,
//     vehicleType,
//     String paymentMethod,
//     String scheduledTime,
//   ) async {
//     loading = true;
//     notifyListeners();

//     try {
//       final response = await homeRepository.scheduledRide(
//         promoCode!,
//         vehicleType,
//         paymentMethod,
//         scheduledTime,
//       );
//       if (response.data != null) {}

//       loading = false;
//       notifyListeners();
//       return ApiResponse(success: response.success, message: response.message);
//     } catch (e) {
//       loading = false;
//       debugPrint("error : ${e.toString()}");
//       notifyListeners();

//       return ApiResponse(
//         success: false,
//         message: "Something went wrong  ${e.toString()}",
//       );
//     }
//   }

//   //----------------------------------------Get Due Payment  -------------------------------------------

//   Future<ApiResponse> getDuePayment(String rideId) async {
//     loading = true;
//     notifyListeners();

//     debugPrint("ride id : $rideId");
//     try {
//       final response = await homeRepository.getDuePayemnt(rideId);
//       if (response.data != null) {
//         _duePayment = response.data;
//       }

//       loading = false;
//       notifyListeners();
//       return ApiResponse(success: response.success, message: response.message);
//     } catch (e) {
//       loading = false;
//       debugPrint("error : ${e.toString()}");
//       notifyListeners();

//       return ApiResponse(
//         success: false,
//         message: "Something went wrong  ${e.toString()}",
//       );
//     }
//   }

//   //----------------------------------------  Payment Done  -------------------------------------------

//   Future<ApiResponse> payemntDone(String rideId) async {
//     loading = true;
//     notifyListeners();

//     debugPrint("ride id : $rideId");
//     try {
//       final response = await homeRepository.paymentDone(rideId);
//       loading = false;
//       notifyListeners();
//       return ApiResponse(success: response.success, message: response.message);
//     } catch (e) {
//       loading = false;
//       debugPrint("error : ${e.toString()}");
//       notifyListeners();

//       return ApiResponse(
//         success: false,
//         message: "Something went wrong  ${e.toString()}",
//       );
//     }
//   }

//   //----------------------------------------  Rating -------------------------------------------

//   Future<ApiResponse> rating(
//     String rideId,
//     String rating,
//     String feedback,
//   ) async {
//     loading = true;
//     notifyListeners();

//     debugPrint("ride id : $rideId");
//     try {
//       final response = await homeRepository.rating(rideId, rating, feedback);
//       loading = false;
//       notifyListeners();
//       return ApiResponse(success: response.success, message: response.message);
//     } catch (e) {
//       loading = false;
//       debugPrint("error : ${e.toString()}");
//       notifyListeners();

//       return ApiResponse(
//         success: false,
//         message: "Something went wrong  ${e.toString()}",
//       );
//     }
//   }

//   //----------------------------------------  near by driver  -------------------------------------------

//   Future<ApiResponse<NearByDriverModel>> nearByAvailbeDrvier() async {
//     loading = true;
//     notifyListeners();

//     debugPrint("inside nearby driver : ");
//     try {
//       final response = await homeRepository.nearByVehicle(
//         position?.latitude.toString() ?? "0.0",
//         position?.longitude.toString() ?? "0.0",
//       );

//       if (response.success) {
//         debugPrint("response is : ${response.data}");
//       }
//       loading = false;
//       notifyListeners();
//       return ApiResponse(success: response.success, message: response.message);
//     } catch (e) {
//       loading = false;
//       debugPrint("error : ${e.toString()}");
//       notifyListeners();

//       return ApiResponse(
//         success: false,
//         message: "Something went wrong  ${e.toString()}",
//       );
//     }
//   }
// }


// home_provider.dart
// ✅ CHANGES SUMMARY:
//   1. Debounce reduced 600ms → 300ms (faster suggestions)
//   2. BUG FIX: pickupLocation & destinationLocation were SWAPPED after API call
//   3. NEW: loadRecentSearches() — shows history when search bar is empty
//   4. NEW: searchDestination now passes user lat/lng for proximity-ranked results
//   5. NEW: selectDestination saves place to recent history
//   6. NEW: isSearching flag for loading shimmer in UI


// import 'package:app/screens/home/model/ride_estimate_request_model.dart';
// import 'package:app/screens/home/model/ride_estimate_result_model.dart';
// import 'package:app/screens/home/repository/home_repository.dart';
// import 'package:app/screens/home/service/location_service.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';


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

  RideEstimateResultModel? _allEstemiateREsult;
  final List<VehicleFare> _allVehicleFare = [];
  RideAcceptedSocketModel? confiremRideDetails;
  bool driverArrivedPopupShown = false;
  bool userReached = false;
  bool userRideComplete = false;

  String vehicleType = "";
  String selectedPayment = "Cash";
  GetDuePaymentModel? _duePayment;
  double selectedVehiclePrice = 0.0;

  RideEstimateResultModel? get allEstimatedResult => _allEstemiateREsult;
  List<VehicleFare> get allVehicleFares => _allVehicleFare;
  GetDuePaymentModel? get duePayment => _duePayment;

  final MapController mapController = MapController();
  StreamSubscription<Position>? _positionStream;

  Position? position;
  LatLng? pickupLocation;
  LatLng? destinationLocation;
  String pickupAddress = "";

  List<LatLng> routePoints = [];

  // ✅ NEW: isSearching flag — used in UI to show shimmer/spinner while fetching
  bool isSearching = false;

  Future<void> initLocation() async {
    position = await _locationService.checkAndFetchLocation();

    if (position != null) {
      pickupLocation = LatLng(position!.latitude, position!.longitude);
      mapController.move(pickupLocation!, 16);
    }

    _startLiveLocation();
    await fromLatLongAddress();

    // ✅ NEW: Pre-load recent searches so they appear immediately when sheet opens
    await loadRecentSearches();

    notifyListeners();
  }

  HomeFlow _flow = HomeFlow.searchDestination;
  HomeFlow get flow => _flow;

  // ✅ NEW: Load saved recent searches from SharedPreferences
  Future<void> loadRecentSearches() async {
    final recents = await _locationService.getRecentSearches();
    if (recents.isNotEmpty) {
      destinationSuggestions = recents;
      notifyListeners();
    }
  }

  void _startLiveLocation() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    _positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position pos) {
      pickupLocation = LatLng(pos.latitude, pos.longitude);
      mapController.move(pickupLocation!, 16);
      notifyListeners();
    });
  }

  Future<void> onMapMoved(LatLng? center) async {
    if (center == null) return;
    pickupLocation = center;
    pickupAddress = await _locationService.fromLatLongAddress(center);
    debugPrint("pickupAddress on change: $pickupAddress");
  }

  Future<void> fromLatLongAddress() async {
    if (position != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );
      final place = placemarks.first;
      pickupAddress = "${place.name}, ${place.subLocality}, ${place.locality}";
      notifyListeners();
      debugPrint("address: $pickupAddress");
    }
  }

  List<LocationSearchModel> destinationSuggestions = [];
  Timer? _debounce;

  // ✅ FIX: Reduced debounce 600ms → 300ms for faster response
  // ✅ FIX: Passes user's current lat/lng so Nominatim returns nearby results first
  // ✅ NEW: Shows recent searches when query is empty
  // ✅ NEW: isSearching flag for loading UI
  void searchDestination(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      // ✅ When empty → show recent searches instead of hardcoded fallback
      if (value.isEmpty) {
        await loadRecentSearches();
        return;
      }

      // ✅ Set loading state so UI can show shimmer
      isSearching = true;
      notifyListeners();

      debugPrint("Searching: $value");

      // ✅ FIX: Pass user's current location for proximity-biased results
      destinationSuggestions = await _locationService.searchLocation(
        value,
        nearLat: position?.latitude,
        nearLng: position?.longitude,
      );

      isSearching = false;
      notifyListeners();
    });
  }

  // ✅ FIX: Now also saves the place to recent search history
  void selectDestination(LocationSearchModel place) {
    destinationLocation = LatLng(place.lat, place.lon);
    desinationController.text = place.displayName;
    destinationSuggestions.clear();

    // ✅ NEW: Save to recent history for next session
    _locationService.saveRecentSearch(place);

    notifyListeners();
  }

  Future<void> drawRoute() async {
    if (pickupLocation == null || destinationLocation == null) return;

    routePoints = await _locationService.getRoute(
      pickup: pickupLocation!,
      destination: destinationLocation!,
    );

    _fitCameraToRoute();
    notifyListeners();
  }

  void _fitCameraToRoute() {
    if (routePoints.isEmpty) return;

    double minLat = routePoints.first.latitude;
    double maxLat = routePoints.first.latitude;
    double minLng = routePoints.first.longitude;
    double maxLng = routePoints.first.longitude;

    for (final p in routePoints) {
      minLat = p.latitude < minLat ? p.latitude : minLat;
      maxLat = p.latitude > maxLat ? p.latitude : maxLat;
      minLng = p.longitude < minLng ? p.longitude : minLng;
      maxLng = p.longitude > maxLng ? p.longitude : maxLng;
    }

    final bounds = LatLngBounds(
      LatLng(minLat, minLng),
      LatLng(maxLat, maxLng),
    );

    mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(80)),
    );
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    desinationController.dispose(); // ✅ FIX: dispose controller to prevent leaks
    super.dispose();
  }

  void goToRideSelection() {
    _flow = HomeFlow.selectRide;
    notifyListeners();
  }

  void goBackToSearch() {
    _flow = HomeFlow.searchDestination;
    // ✅ NEW: Reset destination when going back so map is clean
    destinationLocation = null;
    routePoints = [];
    desinationController.clear();
    loadRecentSearches(); // reload recent searches
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
    SocketService().joinRoom(rideId);
  }

  void sendMessages(String rideId, String message) {
    SocketService().sendMessage(rideId, message);
  }

  void showRatingSheet() {
    _flow = HomeFlow.rideCompleted;
    notifyListeners();
  }

  Future<void> onRideAccepted(RideAcceptedSocketModel data) async {
    confiremRideDetails = data;
    _flow = HomeFlow.accepted;
    notifyListeners();
  }

  Future<void> onReachedAtDestination(ReachedDestinationSocket data) async {
    _flow = HomeFlow.reachedDestination;
    notifyListeners();
  }

  bool loading = false;

  // ✅ BUG FIX: pickupLocation and destinationLocation were SWAPPED after API response!
  // Old (wrong):
  //   pickupLocation = LatLng(dropLat, dropLng);       ← set pickup to DROP coords
  //   destinationLocation = LatLng(pickupLat, pickupLng); ← set destination to PICKUP coords
  // Fixed:
  //   pickupLocation = LatLng(pickupLat, pickupLng);
  //   destinationLocation = LatLng(dropLat, dropLng);
  Future<ApiResponse> getAllEstimtedData({
    required String pickupAddress,
    required double pickupLat,
    required double pickupLng,
    required String dropAddress,
    required double dropLat,
    required double dropLng,
  }) async {
    debugPrint(
      "location: $pickupAddress $pickupLat,$pickupLng → $dropAddress $dropLat,$dropLng",
    );

    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.totalEstimateRide(
        RideEstimateRequestModel(
          pickupLocation: RideLocation(
            longitude: pickupLng,
            latitude: pickupLat,
            address: pickupAddress,
          ),
          dropLocation: RideLocation(
            longitude: dropLng,
            latitude: dropLat,
            address: dropAddress,
          ),
        ),
      );

      loading = false;

      if (response.data == null) {
        notifyListeners(); // ✅ FIX: notify even on failure so loading spinner hides
        return ApiResponse(
          success: response.success,
          message: response.message,
        );
      }

      _allEstemiateREsult = response.data;
      _allVehicleFare
        ..clear()
        ..addAll(response.data!.allVehicleFares);

      // ✅ BUG FIX: Was previously swapped — pickup was set to drop coords and vice versa
      pickupLocation = LatLng(pickupLat, pickupLng);
      destinationLocation = LatLng(dropLat, dropLng);

      await drawRoute(); // route now draws correctly between actual pickup → destination

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
        message: "Something went wrong: ${e.toString()}",
      );
    }
  }

  Future<ApiResponse<RideCreatedResposeModel>> createRide(String id) async {
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.rideCreated(
        RideCreatedRequestModel(
          pickupLocation: LocationPoints(
            coordinates: [
              pickupLocation?.longitude ?? 75.8260,
              pickupLocation?.latitude ?? 26.9240,
            ],
          ),
          dropLocation: LocationPoints(
            coordinates: [
              destinationLocation?.longitude ?? 75.8260,
              destinationLocation?.latitude ?? 26.9250,
            ],
          ),
          vehicleType: vehicleType,
          paymentMethod: selectedPayment.toString().toLowerCase(),
        ),
        id,
      );

      loading = false;
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Something went wrong: ${e.toString()}",
      );
    }
  }

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
      notifyListeners();
      return ApiResponse(
        success: false,
        message: "Something went wrong: ${e.toString()}",
      );
    }
  }

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
      notifyListeners();
      return ApiResponse(
        success: false,
        message: "Something went wrong: ${e.toString()}",
      );
    }
  }

  double getDiscountedFare(double originalFare) {
    if (!isCouponApplied || discountPercent == null) return originalFare;
    final discountAmount = originalFare * (discountPercent! / 100);
    return originalFare - discountAmount;
  }

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
      loading = false;
      notifyListeners();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;
      notifyListeners();
      return ApiResponse(
        success: false,
        message: "Something went wrong: ${e.toString()}",
      );
    }
  }

  Future<ApiResponse> getDuePayment(String rideId) async {
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.getDuePayemnt(rideId);
      if (response.data != null) _duePayment = response.data;
      loading = false;
      notifyListeners();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;
      notifyListeners();
      return ApiResponse(
        success: false,
        message: "Something went wrong: ${e.toString()}",
      );
    }
  }

  Future<ApiResponse> payemntDone(String rideId) async {
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.paymentDone(rideId);
      loading = false;
      notifyListeners();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;
      notifyListeners();
      return ApiResponse(
        success: false,
        message: "Something went wrong: ${e.toString()}",
      );
    }
  }

  Future<ApiResponse> rating(
    String rideId,
    String rating,
    String feedback,
  ) async {
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.rating(rideId, rating, feedback);
      loading = false;
      notifyListeners();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;
      notifyListeners();
      return ApiResponse(
        success: false,
        message: "Something went wrong: ${e.toString()}",
      );
    }
  }

  Future<ApiResponse<NearByDriverModel>> nearByAvailbeDrvier() async {
    loading = true;
    notifyListeners();

    try {
      final response = await homeRepository.nearByVehicle(
        position?.latitude.toString() ?? "0.0",
        position?.longitude.toString() ?? "0.0",
      );
      loading = false;
      notifyListeners();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;
      notifyListeners();
      return ApiResponse(
        success: false,
        message: "Something went wrong: ${e.toString()}",
      );
    }
  }
}