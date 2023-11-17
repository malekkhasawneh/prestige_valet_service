import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';

abstract class SocialAuthLocalDataSource {
  Future<String> encryptUserId({required String userId});
}

class SocialAuthLocalDataSourceImpl implements SocialAuthLocalDataSource {
  @override
  Future<String> encryptUserId({required String userId}) async {
    try {
      final key =
      encrypt.Key.fromBase64(Constants.encryptionKey);
      final iv = encrypt.IV.fromBase64(Constants.encryptionIv);

      final encryptor = encrypt.Encrypter(encrypt.AES(key));

      final encrypted = encryptor.encrypt(userId, iv: iv);

      return encrypted.base64;
    } on Exception {
      throw CacheException();
    }
  }
}
