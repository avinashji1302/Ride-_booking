import 'dart:convert';

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/screens/faq/model/faq_model.dart';
import 'package:flutter/cupertino.dart';

class FaqRepository {
  Future<ApiResponse<FaqResultModel>> faq() async {
    final response = await HttpClient.get(ApiEndpoints.faq);

    final json = jsonDecode(response.body);

    debugPrint("json result is : $json");

    /// Wrap LIST into MAP (IMPORTANT)
    final modifiedJson = {
      "success": json["success"],
      "message": json["message"],
      "results": {
        "list": json["results"], // 👈 convert List → Map
      },
    };

    return ApiResponse<FaqResultModel>.fromJson(
      modifiedJson,
      (data) => FaqResultModel.fromJson(data),
    );
  }
}
