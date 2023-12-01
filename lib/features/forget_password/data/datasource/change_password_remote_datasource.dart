import 'package:dio/dio.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/change_password_model.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<ChangePasswordModel> changePassword(
      {required String password, required String email});
}

class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  @override
  Future<ChangePasswordModel> changePassword(
      {required String password, required String email}) async {
    try {
      Response response = await DioHelper.post(
          NetworkConstants.changePasswordEndPoint,
          data: {"email": email, "password": password});
      ChangePasswordModel changePasswordModel =
          ChangePasswordModel.fromJson(response.data);
      return changePasswordModel;
    } on Exception {
      throw ServerException();
    }
  }
}
