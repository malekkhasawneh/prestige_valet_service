import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';

abstract class SplashLocalDataSource {
  Future<bool> checkIsUserLogin();
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
}
