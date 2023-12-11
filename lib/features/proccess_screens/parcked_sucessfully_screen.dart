import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';

class ParkedSuccessfullyScreen extends StatelessWidget {
  const ParkedSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_parking,
                  color: Colors.green,
                  size: 120,
                ),
                Text(
                  Strings.parkedSuccessfully,
                  style: TextStyle(
                      fontFamily: Fonts.sourceSansPro,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            child: Container(
              width: screenWidth * 0.85,
              height: screenHeight * 0.065,
              constraints: const BoxConstraints(maxHeight: 50),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.blackColor),
                  borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  backgroundColor: ColorManager.whiteColor,
                  elevation: 0.2,
                ),
                onPressed: () {
                  BottomNavBarCubit.get(context).setIndex = 0;
                  HomeCubit.get(context).setIsUserCarInRetrieve = false;
                  HomeCubit.get(context).isUserCarParked = true;
                  HomeCubit.get(context).getUserData(context);
                  Navigator.pushReplacementNamed(
                      context, Routes.bottomNvBarScreen);
                },
                child: const Text(
                  Strings.goToHome,
                  style: TextStyle(
                    color: ColorManager.blackColor,
                    fontFamily: Fonts.sourceSansPro,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
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
