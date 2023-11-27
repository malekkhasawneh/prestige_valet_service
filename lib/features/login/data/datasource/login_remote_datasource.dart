import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class LoginRemoteDataSource {
  Future<SignUpModel> login({required String email, required String password});
  Future<UserCredential> loginWithGoogle();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<SignUpModel> login(
      {required String email, required String password}) async {
    try {
      Map<String, dynamic> response =
          await DioHelper.post(NetworkConstants.loginEndPoint, data: {
        "email": email,
        "password": password,
      });
      SignUpModel userModel = SignUpModel.fromJson(response);
      return userModel;
    } on Exception {
      throw ServerException();
    }
  }
  @override
  Future<UserCredential> loginWithGoogle() async {
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
