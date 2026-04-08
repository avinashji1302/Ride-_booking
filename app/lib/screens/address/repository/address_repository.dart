import 'dart:convert';

import 'package:app/config/network/api_endpoints.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/address/model/address_model.dart';
import 'package:flutter/widgets.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AddressRepository {
  /// GET ALL
  Future<List<AddressModel>> getAddresses() async {
    try {
      final token = await AuthStorage().getAccessToken();

      final response = await HttpClient.get(
        ApiEndpoints.getAddress,
        headers: {"Authorization": "Bearer $token"},
      );

      final json = jsonDecode(response.body);

      if (json['success'] != true) {
        throw Exception(json['message']);
      }

      final List list = json['results'] ?? [];

      return list.map((e) => AddressModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("GET ADDRESS ERROR: $e");
      rethrow;
    }
  }

  /// ADD
  Future<void> addAddress(Map<String, dynamic> body) async {
    try {
      final token = await AuthStorage().getAccessToken();

      final response = await HttpClient.post(
        ApiEndpoints.getAddress,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: body,
      );

      final json = jsonDecode(response.body);

      if (!json['success']) {
        throw Exception(json['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// UPDATE
  Future<void> updateAddress(String id, Map<String, dynamic> body) async {
    debugPrint("address response : $body id is ......... $id");
    try {
      final token = await AuthStorage().getAccessToken();

      final response = await HttpClient.put(
        "${ApiEndpoints.getAddress}/$id",
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: body,
      );

      debugPrint("address response : ${response.body}");

      final json = jsonDecode(response.body);

      if (!json['success']) {
        throw Exception(json['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE
  Future<void> deleteAddress(String id) async {
    try {
      final token = await AuthStorage().getAccessToken();

      final response = await HttpClient.delete(
        "${ApiEndpoints.getAddress}/$id",
        headers: {"Authorization": "Bearer $token"},
      );

      final json = jsonDecode(response.body);

      if (!json['success']) {
        throw Exception(json['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// MAKE DEFAULT
  Future<void> makeDefault(String id) async {
    try {
      final token = await AuthStorage().getAccessToken();

      final response = await HttpClient.put(
        "${ApiEndpoints.getAddress}/change-default-address/$id?defaultAddress=true",
        headers: {"Authorization": "Bearer $token"},
      );

      final json = jsonDecode(response.body);

      if (!json['success']) {
        throw Exception(json['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
