import 'dart:convert';

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/screens/landingPage/model.dart/bannner_model.dart';
import 'package:app/screens/landingPage/model.dart/category_model.dart';
import 'package:flutter/cupertino.dart';

class LandingRepository {
  //-------------------------Get Banner---------------------

  Future<ApiResponse<BannerResultModel>> getBanners() async {
    final response = await HttpClient.get(ApiEndpoints.getBanners);

    final json = jsonDecode(response.body);

    debugPrint("raw banner data : $json");

    return ApiResponse<BannerResultModel>.fromJson(
      json,
      (data) => BannerResultModel.fromJson(data),
    );
  }

  //-------------------------Category list----------------------

  Future<ApiResponse<CategoryResponseModel>> getCategoryList() async {
    final response = await HttpClient.get(ApiEndpoints.categoryList);

    final json = jsonDecode(response.body);

    debugPrint("category list raw data....... : $json");

    return ApiResponse<CategoryResponseModel>.fromJson(
      json,
      (data) => CategoryResponseModel.fromJson(data),
    );
  }
}
