import 'dart:convert';
import 'dart:io';

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/profile/model/user_profile_model.dart';
import 'package:flutter/cupertino.dart';

class ProfileRepository {
  //=------------------------logout------------------------

  Future<ApiResponse<void>> logout() async {
    final token = await AuthStorage().getAccessToken();

    debugPrint("token : $token");

    final response = await HttpClient.post(
      ApiEndpoints.logout,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    debugPrint("raw response : ${response.body}");

    final json = jsonDecode(response.body);
    return ApiResponse<void>.fromJson(json, (_) {});
  }


  //-------------------------------Get Profile---------------------

  Future<ApiResponse<UserProfileModle>> profile() async {
    final token = await AuthStorage().getAccessToken();

    debugPrint("token ......: $token");

    final response = await HttpClient.get(
      ApiEndpoints.profile,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    debugPrint("raw response :.................... ${response.body}");

    final json = jsonDecode(response.body);
    return ApiResponse<UserProfileModle>.fromJson(
      json,
      (data) => UserProfileModle.fromJson(data),
    );
  }

  //------------------------------- getting image Url of profiel--------------------------------

  Future<ApiResponse<String>> uploadProfileImage(File imageFile) async {
    final token = await AuthStorage().getAccessToken();

    debugPrint("token ......: $token");

    final response = await HttpClient.multipart(
      ApiEndpoints.uploadImage,
      file: imageFile,
      fieldName: "image",
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    final json = jsonDecode(response.body);

    debugPrint(
      "image response response : ${response.body}. ${json['results']['imageUrl']}",
    );

    return ApiResponse<String>.fromJson(
      json,
     (data) => (data as Map<String, dynamic>)['imageUrl'] as String,
    );
  }

  //----------------------------------------------update profile---------------------------------

  Future<ApiResponse<void>> updateProfile(
    String fullName,
    String address,
    String? profilePic,
  ) async {
    final token = await AuthStorage().getAccessToken();

    debugPrint("token ......: $token");

    final response = await HttpClient.put(
      ApiEndpoints.updateProfile,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },

      body: {"fullName": fullName, "profilePic": profilePic, "address": []},
    );

    debugPrint("updated Profile: response : ${response.body}");

    final json = jsonDecode(response.body);
    return ApiResponse<UserProfileModle>.fromJson(
      json,
      (data) => UserProfileModle.fromJson(data),
    );
  }
}


// "fullName": "John Don",
    // "profilePic": "users/1234567890-uuid.jpg",
    // "address": [
    //   {
    //     "country": "507f1f77bcf86cd799439011",
    //     "zipCode": "132024",
    //     "completeAddress": "Homeaddress 13224, City Name",
    //     "defaultAddress": true,
    //     "floor": "2",
    //     "howToReach": "Near main gate",
    //     "locationObject": {
    //       "type": "Point",
    //       "coordinates": [77.1234, 28.5678]
    //     }
    //   },
    //   {
    //     "country": "507f1f77bcf86cd799439011",
    //     "zipCode": "110001",
    //     "completeAddress": "Office address, Building name",
    //     "defaultAddress": false,
    //     "floor": "5",
    //     "howToReach": "",
    //     "locationObject": {
    //       "type": "Point",
    //       "coordinates": [77.2000, 28.6000]
    //     }
    //   }
    // ]