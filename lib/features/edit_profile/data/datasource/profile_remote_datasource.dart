import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class ProfileRemoteDataSource {
  Future<User> editProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<User> editProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
  }) async {
    try {
      await DioHelper.addTokenHeader();
      Map<String, dynamic> response = await DioHelper.patch(
          '${NetworkConstants.editProfile}?userId=$userId',
          data: {
            "firstName": firstName,
            "lastName": lastName,
            "phone": phone,
            "email": email,
          });
      User userModel = User.fromJson(response);
      return userModel;
    } on Exception {
      throw ServerException();
    }
  }
}
