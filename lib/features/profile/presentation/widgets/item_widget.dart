

import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Container(
          width: ProfileCubit.get(context).isTablet(screenWidth)
              ? screenWidth * 0.1
              : screenWidth * 0.12,
          height: ProfileCubit.get(context).isTablet(screenWidth)
              ? screenWidth * 0.1
              : screenHeight * 0.058,
          decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            icon,
            color: ColorManager.whiteColor,
            size: 19,
          ),
        ),
        title: Text(title),
        trailing: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
