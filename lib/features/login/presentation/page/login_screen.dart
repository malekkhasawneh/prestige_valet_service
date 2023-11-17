import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/login/presentation/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
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
              ],
            ),
          );
        },
      ),
    );
  }
}
