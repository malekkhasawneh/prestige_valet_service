import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/features/pick_up/data/model/gates_model.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({super.key, required this.gate, required this.onTap});

  final GatesContent gate;
  final void Function()? onTap;

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
          color: gate.isSelected ? Colors.pinkAccent : ColorManager.greyColor,
        ),
        child: Center(
          child: Text(
            gate.gateName,
          ),
        ),
      ),
    );
  }
}
