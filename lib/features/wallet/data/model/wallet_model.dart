class WalletModel {
  int id;
  String cardNumber;
  String cardHolderName;
  String expiryMonth;
  String expiryYear;

  WalletModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryMonth,
    required this.expiryYear,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    id: json["id"],
    cardNumber: json["cardNumber"],
    cardHolderName: json["cardHolderName"],
    expiryMonth: json["expiryMonth"],
    expiryYear: json["expiryYear"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cardNumber": cardNumber,
    "cardHolderName": cardHolderName,
    "expiryMonth": expiryMonth,
    "expiryYear": expiryYear,
  };
}
