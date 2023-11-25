import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: screenWidth * 0.85,
        height: screenHeight * 0.065,
        constraints: const BoxConstraints(maxHeight: 50),
        child: ElevatedButton(
          onPressed: () async {
            SignUpCubit.get(context).setMustCheck = true;

            await SignUpCubit.get(context).signUp();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(25), // Adjust the radius as needed
            ),
          ),
          child: const Text(
            Strings.signUp,
            style: TextStyle(
              fontFamily: Fonts.sourceSansPro,
              fontSize: 13,
              color: ColorManager.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
