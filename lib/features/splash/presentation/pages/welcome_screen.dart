import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/splash/presentation/widgets/get_started_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 55),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                Strings.prestigeValet,
                style: TextStyle(
                    fontFamily: Fonts.sourceSansPro,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20,),
              const Text(
                Strings.welcomeDes,
                style: TextStyle(
                  fontFamily: Fonts.sourceSansPro,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Image.asset(Images.welcomeLogo),
              const SizedBox(height: 70,),
              const GetStartedButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
