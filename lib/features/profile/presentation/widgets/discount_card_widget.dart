import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';

class DisCountCardWidget extends StatelessWidget {
  const DisCountCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 10, horizontal: screenWidth * 0.04),
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: ProfileCubit.get(context).isTablet(screenWidth) ? 40 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.whiteColor.withOpacity(0.9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            Strings.getTenOff,
            style: TextStyle(
                fontFamily: Fonts.sourceSansPro,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            Strings.referTest,
            style: TextStyle(
              fontFamily: Fonts.montserrat,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.35,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                        color: ColorManager.blackColor, width: 1),
                  ),
                  child: const Text(
                    Strings.shareCode,
                    style: TextStyle(
                      fontFamily: Fonts.sourceSansPro,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              const Text(
                Strings.learnMore,
                style: TextStyle(
                  fontFamily: Fonts.sourceSansPro,
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
