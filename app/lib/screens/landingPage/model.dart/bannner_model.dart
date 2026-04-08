

class BannerResultModel {
  final List<BannerModel> list;
  final String count;

  BannerResultModel({
    required this.list,
    required this.count,
  });

  factory BannerResultModel.fromJson(Map<String, dynamic>? json) {
    final bannerList = json?["list"] as List? ?? [];

    return BannerResultModel(
      list: bannerList
          .map((e) => BannerModel.fromJson(e))
          .toList()
          .cast<BannerModel>(),
      count: json?["count"]?.toString() ?? "0",
    );
  }
}


class BannerModel {
  final String id;
  final String title;
  final String file;
  final String sequence;

  BannerModel({
    required this.id,
    required this.title,
    required this.file,
    required this.sequence,
  });

  /// ---------- FROM JSON ----------
  factory BannerModel.fromJson(Map<String, dynamic>? json) {
    return BannerModel(
      id: json?["_id"]?.toString() ?? "",
      title: json?["title"]?.toString() ?? "",
      file: json?["file"]?.toString() ?? "",
      sequence: json?["sequence"]?.toString() ?? "",
    );
  }

  
}