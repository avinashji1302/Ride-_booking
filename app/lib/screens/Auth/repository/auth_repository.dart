import 'dart:convert';

import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/Auth/model/forget_passowrd_model.dart';
import 'package:app/screens/Auth/model/login_with_otp_model.dart';
import 'package:app/screens/Auth/model/otp_varify_model.dart';
import 'package:app/screens/Auth/model/reset_password_model.dart';
import 'package:app/screens/Auth/model/signin_model.dart';
import 'package:app/screens/Auth/model/social_registet_response_model.dart';
import 'package:app/screens/Auth/model/user_model.dart';
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
  // Future<SignUpResponse> register(SignupModel request) async {
  //   final response = await HttpClient.post(
  //     ApiEndpoints.register,
  //     body: request.toJson(),
  //   );

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     debugPrint("Sign up model: ${response.body.isEmpty}");

  //     return SignUpResponse.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception("Registration failed");
  //   }
  // }
  Future<ApiResponse<UserModel>> register(SignupModel request) async {
    final response = await HttpClient.post(
      ApiEndpoints.register,
      body: request.toJson(),
    );

    final json = jsonDecode(response.body);

    debugPrint("response raw: $json");

    return ApiResponse<UserModel>.fromJson(
      json,
      (data) => UserModel.fromJson(data),
    );
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
    return ApiResponse<void>.fromJson(json, (_) {});
  }

  //------------------------------Varify Forget Password-------------------

  Future<ApiResponse<void>> resetPassword(ResetPasswordModel request) async {
    final response = await HttpClient.post(
      ApiEndpoints.resetPassword,
      body: request.toJson(),
    );

    debugPrint("respons e: $response");
    final json = jsonDecode(response.body);
    return ApiResponse<void>.fromJson(json, (_) {});
  }

  //----------------------------------Social SignUp-------------------------------------

  Future<ApiResponse<SocialRegistetResponseModel>> socialRegister(
    Map<String, dynamic> body,
  ) async {
    final response = await HttpClient.post(
      ApiEndpoints.socialSignUp,
      body: body,
    );

    debugPrint("social Response e: $response");
    final json = jsonDecode(response.body);

    debugPrint("Soemtethign wnet : ${response.body}");

    return ApiResponse<SocialRegistetResponseModel>.fromJson(
      json,
      (data) => SocialRegistetResponseModel.fromJson(data),
    );
  }

  //---------------------------------------Signin with OTP---------------------------

  Future<ApiResponse<LoginWithOtpModel>> loginWithOtp(
    Map<String, dynamic> body,
    bool isPhone,
  ) async {
    debugPrint("body : $body $isPhone");
    final loginUrl = isPhone
        ? ApiEndpoints.sendLoginOtp
        : ApiEndpoints.sendEmailLoginOtp;

    final response = await HttpClient.post(loginUrl, body: body);
    debugPrint("raw login data : ${response.body} $response");
    final json = jsonDecode(response.body);

    debugPrint("raw login data : $json");

    return ApiResponse<LoginWithOtpModel>.fromJson(
      json,
      (data) => LoginWithOtpModel.fromJson(data),
    );
  }


  //------------------------------------Varif SignUp with Otp------------------------------

    Future<ApiResponse<SignInResponse>> varifyLoginWithOtp(
    Map<String, dynamic> body,
    bool isPhone,
  ) async {
    debugPrint("body : $body $isPhone");
    final varifyLoginOtp = isPhone
        ? ApiEndpoints.verifyLoginOtp
        : ApiEndpoints.verifyEmailLoginOtp;

    final response = await HttpClient.post(varifyLoginOtp, body: body);
    debugPrint("raw login data : ${response.body} $response");
    final json = jsonDecode(response.body);

    debugPrint("raw varify login data : $json");

    return ApiResponse<SignInResponse>.fromJson(
      json,
      (data) => SignInResponse.fromJson(data),
    );
  }


  //--------------------------------------Resend the OTP-------------------------------------------


 

  Future<ApiResponse<LoginWithOtpModel>> resendOtp(
    Map<String, dynamic> body,
    bool isPhone,
  ) async {
    debugPrint("body : $body $isPhone");
    final loginUrl = isPhone
        ? ApiEndpoints.resendOTPMobile
        : ApiEndpoints.resendEmailLoginOtp;

    final response = await HttpClient.post(loginUrl, body: body);
    debugPrint("raw login data : ${response.body} $response");
    final json = jsonDecode(response.body);

    debugPrint("raw login data : $json");

    return ApiResponse<LoginWithOtpModel>.fromJson(
      json,
      (data) => LoginWithOtpModel.fromJson(data),
    );
  }
  
// }
 
}
