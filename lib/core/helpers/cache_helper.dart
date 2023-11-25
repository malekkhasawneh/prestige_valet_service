import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  static final CacheHelper _instance = CacheHelper._internal();
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  factory CacheHelper() {
    return _instance;
  }

  CacheHelper._internal();

  static Future<void> setValue(
      {required String key, required dynamic value}) async {
    await secureStorage.write(
      key: key,
      value: value,
    );
  }

  static Future<String> getValue({required String key}) async {
    return await secureStorage.read(
          key: key,
        ) ??
        '';
  }

  static Future<void> clear() async {
    await secureStorage.deleteAll();
  }
}