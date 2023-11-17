import 'package:flutter/material.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/cubit/pick_up_cubit.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({super.key, required this.gate});

  final Map<String, dynamic> gate;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        PickUpCubit.get(context).setSelectedGate = gate['id'];
      },
      child: Container(
        width: screenWidth * 0.3,
        height: screenHeight * 0.13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15,
          ),
          color: PickUpCubit.get(context).getSelectedGate == gate['id']
              ? Colors.pinkAccent
              : Colors.grey.withOpacity(0.1),
        ),
        child: Center(
          child: Text(
            gate['gate'],
          ),
        ),
      ),
    );
  }
}
