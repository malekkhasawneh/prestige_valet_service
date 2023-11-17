import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';

class AddPaymentMethodWidget extends StatelessWidget {
  const AddPaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          top: WalletCubit.get(context).headerBoxHeight(context, screenHeight) -
              21.5),
      child: SizedBox(
        width: screenWidth * 0.8,
        height: 43,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.addCreditCardScreen);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.blackColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(25), // Adjust the radius as needed
            ),
          ),
          child: const Text(
            Strings.addPaymentMethod,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorManager.whiteColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
