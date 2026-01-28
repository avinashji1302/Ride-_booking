

import 'dart:convert';

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/old_money/model/upi_payemnt_response_model.dart';
import 'package:flutter/material.dart';


class OlaMoneyRepository {

  Future<ApiResponse<UpiPayemntResponseModel>> getAdminPaymentDetails() async{

       final token = await AuthStorage().getAccessToken();

    debugPrint("Debug token::::: : $token");

    final response = await HttpClient.get(
      ApiEndpoints.upiPayment,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },
    
    );

    debugPrint(("Rawa data Ride estimate : ${response.body}"));
    final json = jsonDecode(response.body);

    return ApiResponse<UpiPayemntResponseModel>.fromJson(
      json,
      (data) => UpiPayemntResponseModel.fromJson(data),
    );

  }

  Future<ApiResponse<UpiPayemntResponseModel>> wallerRecharge(String amount, String upiTransactionId, String upiId, String notes) async{

       final token = await AuthStorage().getAccessToken();

    debugPrint("Debug token::::: : $token $amount $upiTransactionId $upiId $notes");

    final response = await HttpClient.post(
      ApiEndpoints.walletRechare,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },

      body: {
        "paymentMethod": "upi",
        "amount":amount,
        "upiTransactionId": upiTransactionId,
        "upiId":upiId,
        "notes":notes
      }
    
    );

    debugPrint(("Rawa data wallet Rechareg : ${response.body}"));
    final json = jsonDecode(response.body);

    return ApiResponse<UpiPayemntResponseModel>.fromJson(
      json,
      (data) => UpiPayemntResponseModel.fromJson(data),
    );

  }
}

// "paymentMethod": "upi",
//     "amount": 500,
//     "upiTransactionId": "TXN123456789012345",
//     "upiId": "user@paytm",
//     "notes": "Wallet recharge via UPI"