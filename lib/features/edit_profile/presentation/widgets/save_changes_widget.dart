import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';

class SaveChangesWidget extends StatelessWidget {
  const SaveChangesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.9,
      height: 45,
      child: ElevatedButton(
        onPressed: () {
          EditProfileCubit.get(context).editProfile(userId: HomeCubit.get(context).userModel.user.id);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: const Text(
          Strings.saveChanges,
          style: TextStyle(
              fontFamily: Fonts.sourceSansPro,
              color: ColorManager.whiteColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
