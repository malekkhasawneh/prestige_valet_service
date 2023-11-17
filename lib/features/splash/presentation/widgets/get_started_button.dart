import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';

class GetStartedButtonWidget extends StatelessWidget {
  const GetStartedButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.85,
      height: screenHeight * 0.065,
      constraints: const BoxConstraints(maxHeight: 50),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.bottomNvBarScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.blackColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(25), // Adjust the radius as needed
          ),
        ),
        child: const Text(
          Strings.getStarted,
          style: TextStyle(
            fontFamily: Fonts.sourceSansPro,
            fontSize: 13,
            color: ColorManager.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
