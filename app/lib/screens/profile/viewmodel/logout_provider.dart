import 'dart:io';

import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/profile/model/user_profile_model.dart';
import 'package:app/screens/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository repository = ProfileRepository();

  final ImagePicker picker = ImagePicker();
  File? galleryFile;

  UserProfileModle? _userDetails;

  UserProfileModle? get  userDetails=>_userDetails;
  //-----------------------------------

 TextEditingController? nameController;
TextEditingController? addressController;

@override
void dispose() {
  nameController?.dispose();
  addressController?.dispose();
  super.dispose();
}

void initializeControllers(String fullName, String address) {
  nameController?.dispose(); // Dispose old controllers if any
  addressController?.dispose();
  
  nameController = TextEditingController(text: fullName);
  addressController = TextEditingController(text: address);
  notifyListeners();
}

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
      isLoading = false;
      notifyListeners();

      if (response.data != null) {
        _userDetails = response.data;
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

  //---------------------upload image-----------

  final ImagePicker _picker = ImagePicker();

  XFile? selectedImage;
  String profilePic = "";

  Future<void> pickImage(ImageSource source) async {
    final XFile? file = await _picker.pickImage(source: source);
    if (file != null) {
      selectedImage = file;

      debugPrint("choosen image : $selectedImage");
      notifyListeners();
    }
  }

  Future<ApiResponse<void>> uploadProfileImage() async {
    isLoading = true;
    notifyListeners();

    try {
      final imageFile = File(selectedImage!.path);

      final response = await repository.uploadProfileImage(imageFile);

      debugPrint("result : $response");

      if(response!=null){
        profilePic=response.data!;
      }

      debugPrint("Data is : ${response}");

      isLoading = false;
      notifyListeners();
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

  //---------------------update Priofile-----------

  Future<ApiResponse> updateProfile(String updatedName ) async {
    isLoading = true;
    notifyListeners();

    debugPrint("data is : $updatedName $profilePic");

    try {
      final response = await repository.updateProfile(updatedName , "somewhere in the middle" , profilePic);
      isLoading = false;

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
