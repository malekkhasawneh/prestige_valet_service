import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/network/network_utils.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/network_constants.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';
import 'package:twitter_login/twitter_login.dart';

abstract class LoginRemoteDataSource {
  Future<SignUpModel> login({required String email, required String password});

  Future<UserCredential> loginWithGoogle();

  Future<UserCredential> signInWithTwitter();

  Future<UserCredential> signInWithFacebook();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<SignUpModel> login(
      {required String email, required String password}) async {
    try {
      Response response =
          await DioHelper.post(NetworkConstants.loginEndPoint, data: {
        "email": email,
        "password": password,
      });
      SignUpModel userModel = SignUpModel.fromJson(response.data);
      await CacheHelper.setValue(
          key: CacheConstants.appToken, value: userModel.token);
      await CacheHelper.setValue(
          key: CacheConstants.userRole, value: userModel.user.role);
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

  @override
  Future<UserCredential> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
        apiKey: dotenv.env[Constants.twitterApiKey]!,
        apiSecretKey: dotenv.env[Constants.twitterApiSecretKey]!,
        redirectURI: dotenv.env[Constants.twitterRedirectUrl]!);
    final authResult = await twitterLogin.login();
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );
    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(
      loginResult.accessToken!.token,
    );
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
