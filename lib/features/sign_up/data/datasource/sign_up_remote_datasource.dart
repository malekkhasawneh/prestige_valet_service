import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class SignUpRemoteDataSource {
  Future<UserModel> signUp({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required bool socialProfile,
    required String imageUrl,
  });
  Future<UserCredential> signInWithGoogle();
}

class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  @override
  Future<UserModel> signUp({
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
      return UserModel.fromJson(response);
    } on Exception {
      throw ServerException();
    }
  }
  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception {
      throw ServerException();
    }
  }
}
