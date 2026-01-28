import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/profile/model/user_profile_model.dart';
import 'package:app/screens/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository repository =ProfileRepository();


UserProfileModle? userDetails ;
  //-----------------------------------

  bool isLoading = false;

  Future<ApiResponse> logout() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.logout();
      isLoading = true;
      AuthStorage().clear();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isLoading = false;
      debugPrint("error : ${e.toString()}");
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Something went wrong  ${e.toString()}",
      );
    }

  }

Future<ApiResponse> getProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.profile();
      isLoading = true;
      

      

      if(response.data!=null){
        userDetails=response.data;
      }
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isLoading = false;
      debugPrint("error : ${e.toString()}");
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Something went wrong  ${e.toString()}",
      );
    }
  }

}
