import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
      if (state is ForgetPasswordError) {
        AwesomeDialog(
          context: context,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          body: const Center(
            child: Text(
              'Please enter correct E-mail\n ',
              style: TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          btnOkOnPress: () {
            Navigator.popUntil(context, (route) => route.settings.name == Routes.forgetPasswordScreen);
          },
          btnOkColor: Colors.red,
        ).show();
      } else if (state is SendResetPasswordOtpLoaded) {
        ForgetPasswordCubit.get(context).setMustCheck = false;
        Navigator.pushNamed(context, Routes.verifyResetPasswordEmailScreen);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back),
          title: const Text(
            Strings.forgetPasswordTitle,
            style: TextStyle(fontSize: 22),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.enterEmailAddress,
                style:
                    TextStyle(color: Colors.grey.withOpacity(.9), fontSize: 15),
              ),
              TextFieldWidget(
                title: '',
                hintText: Strings.enterEmailHint,
                controller: ForgetPasswordCubit.get(context).emailController,
                textInputType: TextInputType.emailAddress,
                mustCheck: ForgetPasswordCubit.get(context).mustCheck,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.065,
                constraints: const BoxConstraints(maxHeight: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorManager.blackColor,
                    )),
                child: ElevatedButton(
                  onPressed: (state is ForgetPasswordLoading)
                      ? () {}
                      : () {
                          ForgetPasswordCubit.get(context).setMustCheck = true;
                          if (!ForgetPasswordCubit.get(context)
                              .isEmailEmpty()) {
                            ForgetPasswordCubit.get(context)
                                .sendResetPasswordOtp();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      backgroundColor: ColorManager.whiteColor,
                      elevation: 0.5),
                  child: (state is ForgetPasswordLoading)
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: ColorManager.blackColor,
                          ),
                        )
                      : Text(
                          Strings.sendVerificationCode,
                          style: TextStyle(
                            color: ColorManager.blackColor,
                            fontFamily: Fonts.sourceSansPro,
                            fontSize:
                                ProfileCubit.get(context).isTablet(screenWidth)
                                    ? 16
                                    : 14,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
