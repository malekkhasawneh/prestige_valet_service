import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:twitter_login/twitter_login.dart';
import 'dart:developer';
class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
        apiKey: '2wB67cUC5uGGxHazhe1UToIlV',
        apiSecretKey: '3UoLoJoqNvPqumQWfp6NUsgBFWxrviUD9KlZgo68AbQMso30b7',
        redirectURI: 'https://prestige-valet-service.firebaseapp.com/__/auth/handler');

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

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
        GestureDetector(
          onTap: () async {
            await signInWithTwitter().then((value){
              log('=============================================== Here ${value.user!.displayName}');
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
