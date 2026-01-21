import 'dart:convert';

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
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
}
