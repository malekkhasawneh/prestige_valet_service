import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';

abstract class LoginLocalDataSource {
  Future<void> setLoginFlag();
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  @override
  Future<void> setLoginFlag() async {
    try {
      await CacheHelper.setValue(key: CacheConstants.userLoginFlag, value: '1');
    } on Exception {
      throw CacheException();
    }
  }
}
