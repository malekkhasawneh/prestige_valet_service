import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
      return Center(
        child: Container(
          width: screenWidth * 0.85,
          height: screenHeight * 0.065,
          constraints: const BoxConstraints(maxHeight: 50),
          child: ElevatedButton(
            onPressed: (state is ForgetPasswordLoading)
                ? () {}
                : () {
                    ForgetPasswordCubit.get(context).setMustCheck = true;
                    if (!ForgetPasswordCubit.get(context)
                        .isPasswordEmptyOrNotMatch()) {
                      ForgetPasswordCubit.get(context).changePassword();
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(25), // Adjust the radius as needed
              ),
            ),
            child: (state is ForgetPasswordLoading)
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: ColorManager.whiteColor,
                    ),
                  )
                : const Text(
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
    });
  }
}
