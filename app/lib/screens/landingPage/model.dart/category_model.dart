class CategoryResponseModel {
  final List<CategoryModel> list;
  final PaginationModel pagination;

  CategoryResponseModel({
    required this.list,
    required this.pagination,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryResponseModel(
      list: (json['list'] as List<dynamic>? ?? [])
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      pagination:
          PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "list": list.map((e) => e.toJson()).toList(),
        "pagination": pagination.toJson(),
      };
}

//-------------------------------------------------------------

class CategoryModel {
  final String id;
  final String name;
  final String colorCode;
  final String categoryType;
  final String status;
  final String file;
  final DateTime? createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.colorCode,
    required this.categoryType,
    required this.status,
    required this.file,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      colorCode: json['colorCode'] ?? '',
      categoryType: json['categoryType'] ?? '',
      status: json['status'] ?? '',
      file: json['file'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "colorCode": colorCode,
        "categoryType": categoryType,
        "status": status,
        "file": file,
        "createdAt": createdAt?.toIso8601String(),
      };
}

//-------------------------------------------------------------

class PaginationModel {
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  PaginationModel({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      totalPages: json['totalPages'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "pageSize": pageSize,
        "totalPages": totalPages,
      };
}