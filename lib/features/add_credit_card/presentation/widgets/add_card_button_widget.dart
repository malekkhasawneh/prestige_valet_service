import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/cubit/add_credit_card_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';

class AddCardButtonWidget extends StatelessWidget {
  const AddCardButtonWidget({super.key, required this.isFromEdit,required this.onPressed});

  final bool isFromEdit;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.9,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: const Text(
          Strings.addCard,
          style: TextStyle(
              fontFamily: Fonts.sourceSansPro,
              color: ColorManager.whiteColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
