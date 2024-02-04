import 'package:prestige_valet_app/core/helpers/encryptor_helper.dart';

class WalletModel {
  int id;
  String cardNumber;
  String cardHolderName;
  String expiryDate;

  WalletModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        id: json["id"],
        cardNumber: EncryptorHelper.decryptValue(json["cardNumber"]),
        cardHolderName: EncryptorHelper.decryptValue(json["cardHolderName"]),
        expiryDate: EncryptorHelper.decryptValue(json["expiryDate"]),
      );
}
