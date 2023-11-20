import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prestige_valet_app/core/resources/images.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

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
        GestureDetector(onTap: ()async{
          final googleSignIn = GoogleSignIn();
          await googleSignIn.signIn().then((value) {
            log('================================== ${value!.email}');
            log('================================== ${value.displayName}');
            log('================================== ${value.id}');
            log('================================== ${value.photoUrl}');
          });
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
