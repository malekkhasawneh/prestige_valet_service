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
        alignment: Alignment.topCenter,
        children: [
          const Positioned(
            top: 40,
            child: Center(
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: ColorManager.blackColor.withOpacity(.4),
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: ColorManager.blackColor.withOpacity(.4),
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Parking'),
                    Text('2 JD'),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Wash car'),
                    Text('2 JD'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: ColorManager.blackColor.withOpacity(.4),
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Total           4JD',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
