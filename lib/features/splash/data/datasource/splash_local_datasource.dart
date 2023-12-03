import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';

abstract class SplashLocalDataSource {
  Future<bool> checkIsUserLogin();

  Future<bool> isFirstTimeOpenTheApp();

  Future<void> setIsFirstTimeOpenTheApp();

  Future<bool> isUser();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  @override
  Future<bool> checkIsUserLogin() async {
    try {
      return await CacheHelper.getValue(
              key: CacheConstants.userLoginFlag, nullHandler: '0') ==
          '1';
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<bool> isFirstTimeOpenTheApp() async {
    try {
      return await CacheHelper.getValue(
              key: CacheConstants.isFirstTimeOpenTheApp, nullHandler: '1') ==
          '1';
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<void> setIsFirstTimeOpenTheApp() async {
    try {
      await CacheHelper.setValue(
          key: CacheConstants.isFirstTimeOpenTheApp, value: '0');
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<bool> isUser() async {
    try {
      return await CacheHelper.getValue(key: CacheConstants.userRole) ==
          Constants.userRole;
    } on Exception {
      throw CacheException();
    }
  }
}
