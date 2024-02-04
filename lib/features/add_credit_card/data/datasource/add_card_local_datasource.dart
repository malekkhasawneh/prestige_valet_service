import 'dart:developer';

import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/database_helper.dart';
import 'package:prestige_valet_app/core/helpers/encryptor_helper.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';

abstract class AddCardLocalDataSource {
  Future<bool> addNewCard(
      {required int walletId,
      required String holderName,
      required String cardNumber,
      required String expiryDate,
      required bool isFromEdit});
}

class AddCardLocalDataSourceImpl implements AddCardLocalDataSource {
  @override
  Future<bool> addNewCard(
      {required int walletId,
      required String holderName,
      required String cardNumber,
      required String expiryDate,
      required bool isFromEdit}) async {
    try {
      await DioHelper.addTokenHeader();
      int response = !isFromEdit
          ? await DatabaseHelper.insertCard({
              'cardHolderName': EncryptorHelper.encryptValue(holderName),
              'cardNumber': EncryptorHelper.encryptValue(cardNumber),
              'expiryDate': EncryptorHelper.encryptValue(expiryDate),
            })
          : await DatabaseHelper.updateCard(
              {
                'cardHolderName': EncryptorHelper.encryptValue(holderName),
                'cardNumber': EncryptorHelper.encryptValue(cardNumber),
                'expiryDate': EncryptorHelper.encryptValue(expiryDate),
              },
              walletId,
            );
      log('===================================== response $response');
      if (response != 0) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      throw CacheException();
    }
  }
}
