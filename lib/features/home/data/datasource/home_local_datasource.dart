import 'dart:convert';

import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

abstract class HomeLocalDataSource {
  Future<SignUpModel> getUserData();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<SignUpModel> getUserData() async {
    try {
      final String response =
          await CacheHelper.getValue(key: CacheConstants.userModel);
      SignUpModel userModel = SignUpModel.fromJson(jsonDecode(response));
      await CacheHelper.setValue(key: CacheConstants.appToken, value: userModel.token);
      return userModel;
    } on Exception {
      throw CacheException();
    }
  }
}
