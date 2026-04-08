import 'package:flutter/cupertino.dart';

class FaqResultModel {
  final List<FaqModel> results;

  FaqResultModel({required this.results});

  factory FaqResultModel.fromJson(Map<String, dynamic>? json) {
    final list = json?["list"] as List? ?? [];

    return FaqResultModel(
      results:
          list.map((e) => FaqModel.fromJson(e)).toList(),
    );
  }
}

class FaqModel {
  final String id;
  final String title;
  final String content;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String version;
  final String sequence;

  FaqModel({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.sequence,
  });

  /// -------- FROM JSON ----------
  factory FaqModel.fromJson(Map<String, dynamic>? json) {
    return FaqModel(
      id: json?["_id"]?.toString() ?? "",
      title: json?["title"]?.toString() ?? "",
      content: json?["content"]?.toString() ?? "",
      status: json?["status"]?.toString() ?? "",
      createdAt: json?["createdAt"]?.toString() ?? "",
      updatedAt: json?["updatedAt"]?.toString() ?? "",
      version: json?["__v"]?.toString() ?? "0",
      sequence: json?["sequence"]?.toString() ?? "0",
    );
  }
}
