import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:twitter_login/twitter_login.dart';

class SocialLoginRow extends StatelessWidget {
  SocialLoginRow({super.key});

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      log('================================================= error $error');
      throw Exception();
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
        apiKey: '2wB67cUC5uGGxHazhe1UToIlV',
        apiSecretKey: '3UoLoJoqNvPqumQWfp6NUsgBFWxrviUD9KlZgo68AbQMso30b7',
        redirectURI: 'prestige-valet-service://');

    // Trigger the sign-in flow
    final authResult = await twitterLogin.loginV2();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          Images.twitterLogo,
          width: screenWidth * 0.15,
          height: screenHeight * 0.15,
        ),
        GestureDetector(
          onTap: () async {
          },
          child: Image.asset(
            Images.gmailLogo,
            width: screenWidth * 0.15,
            height: screenHeight * 0.15,
          ),
        ),
        Image.asset(
          Images.facebookLogo,
          width: screenWidth * 0.15,
          height: screenHeight * 0.15,
        ),
        Image.asset(
          Images.appleLogo,
          width: screenWidth * 0.15,
          height: screenHeight * 0.15,
        ),
      ],
    );
  }
}
