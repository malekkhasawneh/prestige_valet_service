import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/features/wallet/presentation/page/wallet_screen.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/fonts.dart';
import '../../core/resources/strings.dart';

class CarReadyScreen extends StatelessWidget {
  const CarReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: ColorManager.blackColor,
                  size: 120,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  Strings.carReady,
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
            bottom: 80,
            child: SizedBox(
              width: screenWidth * 0.8,
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
                  Navigator.pushReplacementNamed(context, Routes.successScreen);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.money,
                      color: ColorManager.blackColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      Strings.payWithCash,
                      style: TextStyle(
                        color: ColorManager.blackColor,
                        fontFamily: Fonts.sourceSansPro,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            child: SizedBox(
              width: screenWidth * 0.8,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WalletScreen(
                        isFromPayScreen: true,
                        isPaymentMethod: true,
                      ),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.money,
                      color: ColorManager.blackColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      Strings.payWithCard,
                      style: TextStyle(
                        color: ColorManager.blackColor,
                        fontFamily: Fonts.sourceSansPro,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
