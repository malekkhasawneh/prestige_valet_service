class NotificationModel {
  NotificationContent content;

  NotificationModel({
    required this.content,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    content: List<NotificationContent>.from(json["content"].map((x) => NotificationContent.fromJson(x))).first,
  );
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
