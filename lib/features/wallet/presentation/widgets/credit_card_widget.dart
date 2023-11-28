import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
    required this.name,
    required this.cardNumber,
  });

  final String name;
  final String cardNumber;

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
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.creditCardOverView,
                      style: TextStyle(
                        fontFamily: Fonts.sourceSansPro,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
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
                Text(Strings.creditCardNumber(cardNumber)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.addCreditCardScreen);
            },
            child: Positioned(
              top: 5,
              right: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: ColorManager.blackColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit,
                    color: ColorManager.whiteColor,
                    size: 12,
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 13,
            right: 0,
            child: Icon(
              Icons.credit_card,
              color: ColorManager.primaryColor,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }
}
