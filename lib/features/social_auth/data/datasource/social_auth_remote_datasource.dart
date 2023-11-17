import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';

abstract class SocialAuthRemoteDataSource {
  Future<UserCredential> signInUsingGmail();

  Future<UserCredential> signInUsingFacebook();
}

class SocialAuthRemoteDataSourceImpl implements SocialAuthRemoteDataSource {
  @override
  Future<UserCredential> signInUsingGmail() async {
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
  Future<UserCredential> signInUsingFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email'],
      );

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on Exception {
      throw ServerException();
    }
  }
}
