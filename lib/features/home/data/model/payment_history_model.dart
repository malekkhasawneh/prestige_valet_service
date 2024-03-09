class PaymentHistoryModel {
  final List<PaymentHistoryContent> content;

  PaymentHistoryModel({
    required this.content,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryModel(
        content: List<PaymentHistoryContent>.from(
            json["content"].map((x) => PaymentHistoryContent.fromJson(x))),
      );
}

class PaymentHistoryContent {
  final DateTime createdOn;
  final String createdBy;
  final DateTime updatedOn;
  final String updatedBy;
  final int id;
  final String type;
  final double amount;
  final String currency;
  final String paymentDescription;
  final String recipientEmail;
  final DateTime created;
  final bool confirmedByValet;
  final int parkingId;
  final int gateId;
  final int userId;
  final String gateName;
  final String locationName;

  PaymentHistoryContent({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.type,
    required this.amount,
    required this.currency,
    required this.paymentDescription,
    required this.recipientEmail,
    required this.created,
    required this.confirmedByValet,
    required this.parkingId,
    required this.gateId,
    required this.userId,
    required this.gateName,
    required this.locationName,
  });

  factory PaymentHistoryContent.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryContent(
        createdOn: DateTime.parse(json["createdOn"] ?? DateTime.now().toString()),
        createdBy: json["createdBy"]??'',
        updatedOn: DateTime.parse(json["updatedOn"]?? DateTime.now().toString()),
        updatedBy: json["updatedBy"]??'',
        id: json["id"]??-1,
        type: json["type"]??'',
        amount: json["amount"] ?? 0.0,
        currency: json["currency"]??'',
        paymentDescription: json["paymentDescription"]??'',
        recipientEmail: json["recipientEmail"]??'',
        created: DateTime.parse(json["created"]??DateTime.now().toString()),
        confirmedByValet: json["confirmedByValet"] ?? false,
        parkingId: json["parkingId"]??-1,
        gateId: json["gateId"]??-1,
        userId: json["userId"]??-1,
        gateName: json["gateName"]??'',
        locationName: json["locationName"]??'',
      );

  Map<String, dynamic> toJson() => {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "type": type,
        "amount": amount,
        "currency": currency,
        "paymentDescription": paymentDescription,
        "recipientEmail": recipientEmail,
        "created": created.toIso8601String(),
        "confirmedByValet": confirmedByValet,
        "parkingId": parkingId,
        "gateId": gateId,
        "userId": userId,
        "gateName": gateName,
        "locationName": locationName,
      };
}
