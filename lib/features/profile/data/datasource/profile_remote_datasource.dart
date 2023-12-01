import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';

abstract class UserProfileRemoteDataSource {
  Future<bool> logout({required int userId});
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  @override
  Future<bool> logout({required int userId}) async {
    try {
      await DioHelper.addTokenHeader();
      Response response =
          await DioHelper.post(NetworkConstants.logoutEndPoint(userId));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      throw ServerException();
    }
  }
}
