import 'dart:convert';

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_estimate_request_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_estimate_result_model.dart';
import 'package:app/screens/home/model/ride_create_model/ride_request_model.dart';
import 'package:app/screens/home/model/ride_create_model/ride_response_model.dart';
import 'package:flutter/cupertino.dart';

class HomeRepository {
  //-------------------------Estimate Ride---------------------
  Future<ApiResponse<RideEstimateResultModel>> totalEstimateRide(
    RideEstimateRequestModel request,
  ) async {
    final token = await AuthStorage().getAccessToken();

    debugPrint("Debug token::::: : $token");

    final response = await HttpClient.post(
      ApiEndpoints.estimate,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: request.toJson(),
    );

    debugPrint(("Rawa data Ride estimate : ${response.body}"));
    final json = jsonDecode(response.body);

    return ApiResponse<RideEstimateResultModel>.fromJson(
      json,
      (data) => RideEstimateResultModel.fromJson(data),
    );
  }

  //------------Create Ride----------------------------------

  Future<ApiResponse<RideCreatedResposeModel>> rideCreated(
    RideCreatedRequestModel request,
    String id,
  ) async {
    final token = await AuthStorage().getAccessToken();

    final response = await HttpClient.post(
      "${ApiEndpoints.rideCreate}/$id",
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: request.toJson(),
    );

      debugPrint(("Rawa data  create : : ${response.body}"));

    final json = jsonDecode(response.body);

    return ApiResponse<RideCreatedResposeModel>.fromJson(
      json,
      (data) => RideCreatedResposeModel.fromJson(data),
    );
  }
}
