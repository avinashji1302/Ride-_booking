

import 'dart:convert';

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/screens/help/model/help_model.dart';

class HelpRepository {
   Future<ApiResponse<HelpModelResult>> getStaticSlug() async {
      final response = await HttpClient.get(ApiEndpoints.getStaticSlug);

    final json = jsonDecode(response.body);

    final modifiedJson = {
      "success": json["success"],
      "message": json["message"],
      "results": {
        "list": json["results"],
      }
    };

    return ApiResponse<HelpModelResult>.fromJson(
      modifiedJson,
      (data) => HelpModelResult.fromJson(data),
    );
  }
}