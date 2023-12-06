import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';

abstract class NavLocalDataSource {
  Future<bool> mustResetNotificationToken();

  Future<void> setMustResetNotificationToken();
}

class NavLocalDataSourceImpl implements NavLocalDataSource {
  @override
  Future<bool> mustResetNotificationToken() async {
    try {
      return await CacheHelper.getValue(
              key: CacheConstants.resetNotificationToken, nullHandler: '1') ==
          '1';
    } on Exception {
      throw CacheException();
    }
  }

  @override
  Future<void> setMustResetNotificationToken() async {
    try {
      await CacheHelper.setValue(
          key: CacheConstants.resetNotificationToken, value: '0');
    } on Exception {
      throw CacheException();
    }
  }
}
