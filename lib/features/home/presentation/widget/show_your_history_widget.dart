import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';

class ShowYourHistoryWidget extends StatelessWidget {
  const ShowYourHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.85,
      height: screenHeight * 0.065,
      constraints: const BoxConstraints(maxHeight: 50),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.blackColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.valetHistoryScreen);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          backgroundColor: ColorManager.whiteColor,
            elevation: 0.5
          ),
          child: const Text(
            Strings.showYourHistory,
            style: TextStyle(
              color: ColorManager.blackColor,
              fontFamily: Fonts.sourceSansPro,
              fontWeight: FontWeight.bold
            ),
          )),
    );
  }
}
