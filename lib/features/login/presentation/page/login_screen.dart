import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:prestige_valet_app/features/login/presentation/widgets/login_button_widget.dart';
import 'package:prestige_valet_app/features/login/presentation/widgets/social_login_row.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.06,
                    top: screenHeight * 0.06,
                    bottom: screenHeight * 0.04,
                  ),
                  child: const Text(
                    Strings.loginTitle,
                    style: TextStyle(
                        fontFamily: Fonts.sourceSansPro,
                        fontSize: 26,
                        color: ColorManager.blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextFieldWidget(
                  title: Strings.email,
                  hintText: Strings.emailHint,
                  controller: LoginCubit.get(context).emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  title: Strings.password,
                  hintText: Strings.passwordHint,
                  controller: LoginCubit.get(context).passwordController,
                  textInputType: TextInputType.visiblePassword,
                  isPassword: !LoginCubit.get(context).showPassword,
                  addSuffixIcon: true,
                  suffixIcon: IconButton(
                    highlightColor: ColorManager.transparent,
                    onPressed: () {
                      LoginCubit.get(context).setShowPassword =
                      !LoginCubit.get(context).showPassword;
                    },
                    icon: Icon(
                      LoginCubit.get(context).showPassword
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                      color: ColorManager.primaryColor,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const LoginButtonWidget(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    Strings.forgetPassword,
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.9),
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    Strings.or,
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.9),
                      fontSize: 11,
                    ),
                  ),
                ),
                const SocialLoginRow(),
                const Center(
                  child: Text(
                    Strings.doNotHaveAccount,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
