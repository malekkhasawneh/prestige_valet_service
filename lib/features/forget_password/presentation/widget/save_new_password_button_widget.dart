import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';

class SaveNewPasswordButtonWidget extends StatelessWidget {
  const SaveNewPasswordButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: screenWidth * 0.85,
        height: screenHeight * 0.065,
        constraints: const BoxConstraints(maxHeight: 50),
        child: ElevatedButton(
          onPressed: () {
            if ((ForgetPasswordCubit.get(context).passwordController.text ==
                    ForgetPasswordCubit.get(context)
                        .confirmPasswordController
                        .text) &&
                ForgetPasswordCubit.get(context)
                    .passwordController
                    .text
                    .isNotEmpty) {
              ForgetPasswordCubit.get(context).changePassword();
            }else{
              // ignore: invalid_use_of_visible_for_testing_member
              ForgetPasswordCubit.get(context).emit(ForgetPasswordLoading());
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(25), // Adjust the radius as needed
            ),
          ),
          child: const Text(
            Strings.save,
            style: TextStyle(
              fontFamily: Fonts.sourceSansPro,
              fontSize: 13,
              color: ColorManager.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
