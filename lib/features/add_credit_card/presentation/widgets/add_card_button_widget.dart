import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';

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
        child: Text(
          isFromEdit ? Strings.updateCard : Strings.addCard,
          style: const TextStyle(
              fontFamily: Fonts.sourceSansPro,
              color: ColorManager.whiteColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
