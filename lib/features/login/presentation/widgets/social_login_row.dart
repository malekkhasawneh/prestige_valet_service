import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:twitter_login/twitter_login.dart';
import 'dart:developer';
class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

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
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () async {
            await signInWithFacebook().then((value){
              log('=============================================== Here ${value.user!.email}');
            });
          },
          child: Image.asset(
            Images.twitterLogo,
            width: screenWidth * 0.15,
            height: screenHeight * 0.15,
          ),
        ),
        GestureDetector(
          onTap: () {
            LoginCubit.get(context).loginWithGoogle();
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
