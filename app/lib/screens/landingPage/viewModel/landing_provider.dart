import 'package:app/config/device/location_permission.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/landingPage/model.dart/bannner_model.dart';
import 'package:app/screens/landingPage/model.dart/category_model.dart';
import 'package:app/screens/landingPage/reposotory/landing_repository.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


import 'package:provider/provider.dart';

class LandingProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final LandingRepository repository = LandingRepository();
  final LocationService _locationService = LocationService();

  final TextEditingController destinationController = TextEditingController();

  BannerResultModel? allBanner;
  int _index = 0;

  int get index => _index;

  bool isLoading = false;
  List<CategoryModel> categories = [];

  String currentAddress = "";
  String desination = "";
  Position? position;

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  Future<void> loadProfile(BuildContext context) async {
    final profileProvider = context.read<ProfileProvider>();
    await profileProvider.getProfile();
    await getBanners();
    await getCategoryList();

    position = await _locationService.checkAndFetchLocation();
    await fromLatLongAddress();
    notifyListeners();

    debugPrint("location Service.... $position");
  }

  //---------------------Convert current position into address text --------------------

  Future<void> fromLatLongAddress() async {
    if (position != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );

      final place = placemarks.first;

      /// ⭐ Uber style short address
      currentAddress = "${place.name}, ${place.subLocality}, ${place.locality}";

      notifyListeners();
      debugPrint("laddress is : plaxwm.... $currentAddress");
    }
  }

  //-------------------------Switch Navbar--------------------------

  void changeBottemNav(int val) {
    debugPrint("index is : $val");
    if (val == index) {
      return;
    }

    _index = val;

    notifyListeners();
  }
  //----------------------Get banner-------------------------------------

  Future<ApiResponse<BannerResultModel>> getBanners() async {
    isLoading = true;
    ;
    try {
      final response = await repository.getBanners();

      if (response.success) {
        debugPrint("data is : ${response.data} ${response.message}");
        allBanner = response.data;
      }
      isLoading = true;
      notifyListeners();

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isLoading = true;
      return ApiResponse(success: false, message: "someething went wrong : $e");
    }
  }

  //----------------------Get Category-------------------------------------

  Future<ApiResponse<CategoryResponseModel>> getCategoryList() async {
    isLoading = true;
    try {
      final response = await repository.getCategoryList();

      if (response.success) {
        debugPrint("data is : ${response.data} ${response.message}");
        categories = response.data!.list;

        debugPrint("data is : $categories} ${response.message}");
      }
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isLoading = false;
      return ApiResponse(success: false, message: "someething went wrong : $e");
    }
  }
}
