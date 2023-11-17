import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 140,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  Strings.seeYouSoon,
                  style: TextStyle(
                    fontFamily: Fonts.sourceSansPro,
                    fontSize: ProfileCubit.get(context).isTablet(screenWidth)
                        ? 21
                        : 18,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            child: Container(
              width: screenWidth * 0.85,
              height: screenHeight * 0.065,
              constraints: const BoxConstraints(maxHeight: 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorManager.blackColor,
                  )),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    backgroundColor: ColorManager.whiteColor,
                    elevation: 0.5),
                child: Text(
                  Strings.goToHome,
                  style: TextStyle(
                    color: ColorManager.blackColor,
                    fontFamily: Fonts.sourceSansPro,
                    fontSize: ProfileCubit.get(context).isTablet(screenWidth)
                        ? 16
                        : 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
