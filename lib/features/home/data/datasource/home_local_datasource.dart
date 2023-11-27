import 'dart:convert';

import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class HomeLocalDataSource {
  Future<UserModel> getUserData();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<UserModel> getUserData() async {
    try {
      final String response =
          await CacheHelper.getValue(key: CacheConstants.userModel);
      UserModel userModel = UserModel.fromJson(jsonDecode(response));
      await CacheHelper.setValue(key: CacheConstants.appToken, value: userModel.token);
      return userModel;
    } on Exception {
      throw CacheException();
    }
  }
}
