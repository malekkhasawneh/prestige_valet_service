import 'dart:developer';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';

class EncryptorHelper {
  static final encrypt.Key _key =
      encrypt.Key.fromBase64(dotenv.env[Constants.encryptCardDataKey]!);
  static final encrypt.IV _iv =
      encrypt.IV.fromBase64(dotenv.env[Constants.encryptCardDataIv]!);

  static String encryptValue(String text) {
    try {
      final encryptor = encrypt.Encrypter(
        encrypt.AES(
          _key,
          mode: encrypt.AESMode.gcm,
          padding: null,
        ),
      );
      final encrypted = encryptor.encrypt(text, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      log('Encryption error: $e');
      return '';
    }
  }

  static String decryptValue(String encryptedText) {
    try {
      final encryptor = encrypt.Encrypter(
          encrypt.AES(_key, mode: encrypt.AESMode.gcm, padding: null));
      final decrypted = encryptor.decrypt64(
          encryptedText.padRight(
              encryptedText.length + (4 - encryptedText.length % 4) % 4, '='),
          iv: _iv);
      return decrypted;
    } catch (e) {
      log('Decryption error: $e');
      return '';
    }
  }
}
