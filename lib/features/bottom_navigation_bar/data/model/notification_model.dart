class NotificationModel {
  int tokenId;
  int userId;
  String token;

  NotificationModel({
    required this.tokenId,
    required this.userId,
    required this.token,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    tokenId: json["tokenId"],
    userId: json["userId"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "tokenId": tokenId,
    "userId": userId,
    "token": token,
  };
}
