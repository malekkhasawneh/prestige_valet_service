import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';

abstract class NavLocalDataSource {
  Future<bool> mustResetNotificationToken();
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
}
