import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';

abstract class SignUpLocalDataSource {
  Future<void> setUserModel({required String userModel});
}

class SignUpLocalDataSourceImpl implements SignUpLocalDataSource {
  @override
  Future<void> setUserModel({required String userModel}) async {
    try {
      await CacheHelper.setValue(
          key: CacheConstants.userModel, value: userModel);
    } on Exception {
      throw CacheException();
    }
  }
}
