import 'dart:convert';

import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/Auth/model/forget_passowrd_model.dart';
import 'package:app/screens/Auth/model/otp_varify_model.dart';
import 'package:app/screens/Auth/model/reset_password_model.dart';
import 'package:app/screens/Auth/model/signin_model.dart';
import 'package:app/screens/Auth/model/varifty_user_forget_password_model.dart';
import 'package:flutter/material.dart';

import '../../../config/network/api_endpoints.dart';
import '../../../config/network/http_client.dart';
import '../model/signup_model.dart';

class AuthRepository {
  // Future<UserModel> register(SignupModel request) async {
  //   final response = await HttpClient.post(
  //    ApiEndpoints.register,
  //     body: request.toJson(),
  //   );

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     debugPrint("Sign up model: ${response.body}");
  //     return UserModel.fromJson(
  //       jsonDecode(response.body),
  //     );
  //   } else {
  //     throw Exception("Registration failed");
  //   }
  // }

  // register -----------------------Register--------------------------------------
  Future<SignUpResponse> register(SignupModel request) async {
    final response = await HttpClient.post(
      ApiEndpoints.register,
      body: request.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("Sign up model: ${response.body}");
      return SignUpResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Registration failed");
    }
  }

  //-----------------------------OTP Varify--------------------------------------

  Future<ApiResponse<VarifyOtpUserResult>> verifySignUpOtp(
    VerifyOtpRequest request,
  ) async {
    final response = await HttpClient.post(
      ApiEndpoints.verifyOtp,
      body: request.toJson(),
    );

    final json = jsonDecode(response.body);

    return ApiResponse<VarifyOtpUserResult>.fromJson(
      json,
      (data) => VarifyOtpUserResult.fromJson(data),
    );
  }

  //-----------------------------Login------------------------------------------------

  Future<ApiResponse<SignInResponse>> signIn(LoginRequest request) async {
    final response = await HttpClient.post(
      ApiEndpoints.login,
      body: request.toJson(),
    );
    debugPrint("respons e: $response");
    final json = jsonDecode(response.body);

    debugPrint("respons e: $json.  ${response.body}");

    return ApiResponse<SignInResponse>.fromJson(
      json,
      (data) => SignInResponse.fromJson(data),
    );
  }

  //-------------------------------forget password-------------------------------------

  Future<ApiResponse<ForgetPassowrdModel>> forgetPassword(
    ForgetPassowrdModelRequest request,
  ) async {
    final response = await HttpClient.post(
      ApiEndpoints.forgotPassword,
      body: request.toJson(),
    );

    debugPrint("respons e: $response");
    final json = jsonDecode(response.body);
    return ApiResponse<ForgetPassowrdModel>.fromJson(
      json,
      (data) => ForgetPassowrdModel.fromJson(data),
    );
  }

  //------------------------------Varify Forget Password-------------------

  Future<ApiResponse<void>> variftForgetPasswordOtp(
    VariftyUserForgetPasswordModel request,
  ) async {
    final response = await HttpClient.post(
      ApiEndpoints.verifyForgotOtp,
      body: request.toJson(),
    );

    debugPrint("respons e: $response");
    final json = jsonDecode(response.body);
    return ApiResponse<void>.fromJson(
      json,
      (_) {},
    );
  }

    //------------------------------Varify Forget Password-------------------

  Future<ApiResponse<void>> resetPassword(
    ResetPasswordModel request,
  ) async {
    final response = await HttpClient.post(
      ApiEndpoints.resetPassword,
      body: request.toJson(),
    );

    debugPrint("respons e: $response");
    final json = jsonDecode(response.body);
    return ApiResponse<void>.fromJson(
      json,
      (_) {},
    );
  }
}
