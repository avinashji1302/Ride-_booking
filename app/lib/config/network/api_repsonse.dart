// class ApiResponse<T> {
//   final bool success;
//   final String message;
//   final T? data;

//   ApiResponse({
//     required this.success,
//     required this.message,
//     this.data,
//   });

//   factory ApiResponse.fromJson(
//     Map<String, dynamic> json,
//     T Function(dynamic json) fromJsonT,
//   ) {
//     return ApiResponse<T>(
//       success: json['success'],
//       message: json['message'],
//       data: json['results'] != null && json['results'].toString().isNotEmpty
//           ? fromJsonT(json['results'])
//           : null,
//     );
//   }
// }


import 'package:flutter/material.dart';

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    try {
      T? data;
      
      // Only parse data if results is not empty and success is true
      if (json['results'] != null && 
          json['results'] is Map && 
          (json['results'] as Map).isNotEmpty) {
        try {
          data = fromJsonT(json['results']);
        } catch (e) {
          debugPrint("Data parsing error: $e");
          // Don't fail, just set data to null
        }
      }

      return ApiResponse<T>(
        success: json['success'] ?? false,
        message: json['message'] ?? 'Unknown error',
        data: data,
      );
    } catch (e) {
      debugPrint("Parse error: $e");
      return ApiResponse<T>(
        success: false,
        message: 'Failed to process response',
      );
    }
  }
}