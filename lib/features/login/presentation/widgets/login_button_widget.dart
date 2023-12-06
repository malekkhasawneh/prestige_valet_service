import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:prestige_valet_app/features/splash/presentation/cubit/splash_cubit.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Center(
        child: Container(
          width: screenWidth * 0.85,
          height: screenHeight * 0.065,
          constraints: const BoxConstraints(maxHeight: 50),
          child: ElevatedButton(
            onPressed: (state is LoginLoading)
                ? () {}
                : () {
                    LoginCubit.get(context).setMustCheck = true;
                    if (!LoginCubit.get(context).checkIfThereAreEmptyValue()) {
                      SplashCubit.get(context).checkIsUser();
                      LoginCubit.get(context).login();
                      BottomNavBarCubit.get(context).canUpdateToken = true;
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(25), // Adjust the radius as needed
              ),
            ),
            child: (state is LoginLoading)
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: ColorManager.whiteColor,
                    ))
                : const Text(
                    Strings.login,
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