import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/login/presentation/widgets/social_login_row.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/widgets/sign_up_button_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    Images.splashLogo,
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: Text(
                    Strings.signUp,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.withOpacity(0.9),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextFieldWidget(
                        controller:
                            SignUpCubit.get(context).firstNameController,
                        title: '',
                        hintText: Strings.signUpFirstName,
                        textInputType: TextInputType.name,
                        mustCheck: SignUpCubit.get(context).mustCheck,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextFieldWidget(
                        controller: SignUpCubit.get(context).lastNameController,
                        title: '',
                        hintText: Strings.signUpLastName,
                        textInputType: TextInputType.name,
                        mustCheck: SignUpCubit.get(context).mustCheck,
                      ),
                    ),
                  ],
                ),
                TextFieldWidget(
                  controller: SignUpCubit.get(context).phoneController,
                  title: '',
                  hintText: Strings.signUpPhoneNumber,
                  textInputType: TextInputType.name,
                  mustCheck: SignUpCubit.get(context).mustCheck,
                  onlyNumbers: true,
                ),
                TextFieldWidget(
                  controller: SignUpCubit.get(context).emailController,
                  title: '',
                  hintText: Strings.signUpEmailAddress,
                  textInputType: TextInputType.emailAddress,
                  readOnly: SignUpCubit.get(context).hideNormalAuthField,
                  mustCheck: SignUpCubit.get(context).mustCheck,
                ),
                !SignUpCubit.get(context).hideNormalAuthField
                    ? TextFieldWidget(
                        controller: SignUpCubit.get(context).passwordController,
                        title: '',
                        hintText: Strings.signUpPassword,
                        textInputType: TextInputType.visiblePassword,
                        isPassword: !SignUpCubit.get(context).showPassword,
                        addSuffixIcon: true,
                        suffixIcon: IconButton(
                          highlightColor: ColorManager.transparent,
                          onPressed: () {
                            SignUpCubit.get(context).setShowPassword =
                                !SignUpCubit.get(context).showPassword;
                          },
                          icon: Icon(
                            SignUpCubit.get(context).showPassword
                                ? Icons.visibility_off
                                : Icons.remove_red_eye,
                            color: ColorManager.primaryColor,
                            size: 20,
                          ),
                        ),
                        mustCheck: SignUpCubit.get(context).mustCheck,
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 25,
                ),
                const SignUpButtonWidget(),
                !SignUpCubit.get(context).hideNormalAuthField
                    ? Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            Strings.or,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.9),
                            ),
                          ),
                        ),
                        const SocialLoginRow(
                          isFromSignUp: true,
                        )
                      ])
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
