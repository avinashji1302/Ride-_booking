import 'dart:convert';

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/notification/model/notificatation_model.dart';
import 'package:flutter/cupertino.dart';

class NotificationRepository {
  Future<ApiResponse<NotificationResponse>> getNotification() async {
    // 1. Get auth token
    final token = await AuthStorage().getAccessToken();

    // 2. Make the HTTP call via your HttpClient
    final response = await HttpClient.get(
      ApiEndpoints.notifications,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    debugPrint("raw notification: ${response.body}");

    // 3. Decode raw string → Map
    final json = jsonDecode(response.body);

    // 4. Wrap in ApiResponse, pass the fromJson of your model
    return ApiResponse<NotificationResponse>.fromJson(
      json,
      (data) => NotificationResponse.fromJson(data),
    );
  }



//-------------------------seen notification---------------------------

    Future<ApiResponse<NotificationResponse>> seenNotification(bool isEnable) async {
    // 1. Get auth token
    final token = await AuthStorage().getAccessToken();

    // 2. Make the HTTP call via your HttpClient
    final response = await HttpClient.post(
      ApiEndpoints.notificationsToggle,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
     body: {
      "status":isEnable
     }
    );


  debugPrint("raw notification: ${response.body}");
    // 3. Decode raw string → Map
    final json = jsonDecode(response.body);

    // 4. Wrap in ApiResponse, pass the fromJson of your model
    return ApiResponse<NotificationResponse>.fromJson(
      json,
      (data) => NotificationResponse.fromJson(data),
    );
  }
}
