import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      Map<String, dynamic> response =
          await DioHelper.post(NetworkConstants.loginEndPoint, data: {
        "email": email,
        "password": password,
      });
      UserModel userModel = UserModel.fromJson(response);
      return userModel;
    } on Exception {
      throw ServerException();
    }
  }
}
