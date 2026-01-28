import 'dart:convert';

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/home/model/coupon_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_estimate_request_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/ride_estimate_result_model.dart';
import 'package:app/screens/home/model/ride_create_model/ride_request_model.dart';
import 'package:app/screens/home/model/ride_create_model/ride_response_model.dart';
import 'package:app/screens/home/model/ride_scheduled_model.dart';
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

  //----------------------------------Cancel the ride--------------------------------

  Future<ApiResponse<void>> rideCancel({
    required String rideId,
    required String reason,
  }) async {
    final token = await AuthStorage().getAccessToken();

    final response = await HttpClient.post(
      ApiEndpoints.cancelRide,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {"rideId": rideId, "reason": reason},
    );

    debugPrint("Raw data cancel ride: ${response.body}");

    final json = jsonDecode(response.body);

    return ApiResponse<void>.fromJson(json, (_) => null);
  }

  //---------------------------Apply coupon-------------------

  Future<ApiResponse<CouponModel>> applyCoupon(
    String couponCode,
    String userId,
    String rideId,
  ) async {
    final token = await AuthStorage().getAccessToken();
    debugPrint("promot $couponCode $userId $rideId");
    final response = await HttpClient.post(
      ApiEndpoints.coupon,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {"code": couponCode, "userId": userId, "rideId": rideId},
    );

    debugPrint("Raw apply coupon response : ${response.body}");

    final json = jsonDecode(response.body);

    return ApiResponse<CouponModel>.fromJson(
      json,
      (data) => CouponModel.fromJson(data),
    );
  }

   //---------------------------Ride Scheduled-------------------

  Future<ApiResponse<RideScheduledModel>> scheduledRide(
    String promCode,
    String vehicleType,
    String paymentMethod,
    String scheduledTime
  ) async {
    final token = await AuthStorage().getAccessToken();
     final userId = await AuthStorage().getUserId();
    debugPrint("promot $promCode $vehicleType $paymentMethod userid : $userId");
    final response = await HttpClient.post(
      "${ApiEndpoints.schedule}/$userId",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {"vehicleType": vehicleType, "paymentMethod": paymentMethod, "scheduledFor": scheduledTime ,  "promocode": promCode},
    );

    debugPrint("Raw apply coupon response : ${response.body}");

    final json = jsonDecode(response.body);

    

    return ApiResponse<RideScheduledModel>.fromJson(
      json,
      (data) => RideScheduledModel.fromJson(data),
    );
  }
}


