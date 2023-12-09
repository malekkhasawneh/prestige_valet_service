import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
      return SizedBox(
        width: screenWidth * 0.9,
        height: 45,
        child: ElevatedButton(
          onPressed: (state is EditProfileLoading)
              ? () {}
              : () {
                  EditProfileCubit.get(context).setMustCheck = true;
                  if (!EditProfileCubit.get(context)
                      .checkIfThereAreEmptyValue()) {
                    EditProfileCubit.get(context).editProfile(
                        userId: HomeCubit.get(context).userModel.user.id);
                  }
                },
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          child: (state is EditProfileLoading)
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: ColorManager.whiteColor,
                  ))
              : const Text(
                  Strings.saveChanges,
                  style: TextStyle(
                      fontFamily: Fonts.sourceSansPro,
                      color: ColorManager.whiteColor,
                      fontWeight: FontWeight.bold),
                ),
        ),
      );
    });
  }
}
