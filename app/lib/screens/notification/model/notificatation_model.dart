// notification_response.dart

class NotificationResponse {
  final List<NotificationModel> docs;
  final int totalDocs;
  final int limit;
  final int page;
  final int totalPages;

  NotificationResponse({
    required this.docs,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      // json['docs'] is a List, so we map each item → NotificationModel
      docs: List<NotificationModel>.from(
        json['docs'].map((item) => NotificationModel.fromJson(item)),
      ),
      totalDocs: json['totalDocs'],
      limit: json['limit'],
      page: json['page'],
      totalPages: json['totalPages'],
    );
  }
}

// notification_model.dart

class NotificationModel {
  final String id;
  final String userId;
  final String userType;
  final String title;
  final String description;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.userType,
    required this.title,
    required this.description,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON key "_id" → Dart field "id"
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      userId: json['userId'],
      userType: json['userType'],
      title: json['title'],
      description: json['description'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}