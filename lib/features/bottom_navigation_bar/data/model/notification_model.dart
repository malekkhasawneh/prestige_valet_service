class NotificationModel {
  NotificationContent content;
  String message;

  NotificationModel({
    required this.content,
    required this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
          content: List<NotificationContent>.from(
                  json["content"].map((x) => NotificationContent.fromJson(x)))
              .first,
          message: json['message'] ?? '');
}

class NotificationContent {
  int id;
  String notificationToken;

  NotificationContent({
    required this.id,
    required this.notificationToken,
  });

  factory NotificationContent.fromJson(Map<String, dynamic> json) => NotificationContent(
    id: json["id"],
    notificationToken: json["notificationToken"],
  );
}
