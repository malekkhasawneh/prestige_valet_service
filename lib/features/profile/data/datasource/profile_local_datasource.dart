import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';

abstract class ProfileLocalDataSource {
  Future<void> clearCache();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<void> clearCache() async {
    try {
      await CacheHelper.clear();
      await CacheHelper.setValue(
          key: CacheConstants.isFirstTimeOpenTheApp, value: '0');
    } on Exception {
      throw CacheException();
    }
  }
}
