import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';

class GateTypeCardWidget extends StatelessWidget {
  const GateTypeCardWidget(
      {super.key,
      required this.name,
      required this.onTap,
      required this.isSelected});

  final String name;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.3,
        height: screenHeight * 0.13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15,
          ),
          color: isSelected ? Colors.pinkAccent : ColorManager.greyColor,
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: isSelected
                  ? ColorManager.whiteColor
                  : ColorManager.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
