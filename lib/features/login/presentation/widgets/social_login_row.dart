import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';

class SocialLoginRow extends StatelessWidget {
  SocialLoginRow({super.key});

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
