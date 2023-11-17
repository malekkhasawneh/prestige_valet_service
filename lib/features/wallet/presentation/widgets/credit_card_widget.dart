import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xffF0F0F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.creditCardOverView,
                      style: TextStyle(
                        fontFamily: Fonts.sourceSansPro,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Shaker Amayreh',
                      style: TextStyle(
                        fontFamily: Fonts.sourceSansPro,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(Strings.creditCardNumber('0322')),
              ],
            ),
          ),
          const Positioned(
            top: 5,
            right: -6,
            child: Icon(
              Icons.edit,
              color: ColorManager.primaryColor,
              size: 18,
            ),
          ),
          const Positioned(
            bottom: 13,
            right: 0,
            child: Icon(
              Icons.credit_card,
              color: ColorManager.primaryColor,
              size: 17,
            ),
          ),
        ],
      ),
    );
  }
}
