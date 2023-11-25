import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class SignUpRemoteDataSource {
  Future<RegistrationModel> signUp({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required bool socialProfile,
    required String imageUrl,
  });
}

class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  @override
  Future<RegistrationModel> signUp({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required bool socialProfile,
    required String imageUrl,
  }) async {
    try {
      Map<String, dynamic> response =
          await DioHelper.post(NetworkConstants.registerEndPoint, data: {
        "email": email,
        "phone": phone,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "socialProfile": socialProfile,
        "imageUrl": imageUrl,
      });
      return RegistrationModel.fromJson(response);
    } on Exception {
      throw ServerException();
    }
  }
}
