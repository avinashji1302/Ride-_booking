class HelpModelResult {
  final List<HelpModel> pages;

  HelpModelResult({required this.pages});

  factory HelpModelResult.fromJson(Map<String, dynamic>? json) {
    final list = json?["list"] ?? json ?? [];

    return HelpModelResult(
      pages: (list as List)
          .map((e) => HelpModel.fromJson(e))
          .toList(),
    );
  }
}

class HelpModel {
  final String id;
  final String title;
  final String slug;
  final String content;

  HelpModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
  });

  factory HelpModel.fromJson(Map<String, dynamic>? json) {
    return HelpModel(
      id: json?["_id"]?.toString() ?? "",
      title: json?["title"]?.toString() ?? "",
      slug: json?["slug"]?.toString() ?? "",
      content: json?["content"]?.toString() ?? "",
    );
  }
}