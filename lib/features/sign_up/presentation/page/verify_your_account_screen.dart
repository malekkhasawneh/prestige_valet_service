import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';

class VerifyYourAccountScreen extends StatelessWidget {
  const VerifyYourAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is AccountActivatedLoaded) {
          if (state.activatedState) {
            AwesomeDialog(
              context: context,
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              animType: AnimType.scale,
              dialogType: DialogType.success,
              body: const Center(
                child: Text(
                  'Account activated successfully\n',
                  style: TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              btnOkOnPress: () {
                Navigator.pushReplacementNamed(context, Routes.loginScreen);
              },
              btnOkColor: Colors.green,
            ).show();
          } else {
            AwesomeDialog(
              context: context,
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              body: const Center(
                child: Text(
                  'Something wrong please try again\n',
                  style: TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              btnOkOnPress: () {},
              btnOkColor: Colors.red,
            ).show();
          }
        }else if(state is SignUpError){
          AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: const Center(
              child: Text(
                'Something wrong please try again\n',
                style: TextStyle(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            btnOkOnPress: () {},
            btnOkColor: Colors.red,
          ).show();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.arrow_back),
            title: const Text(
              Strings.verifyYourAccount,
              style: TextStyle(fontSize: 22),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.enterOtp,
                  style: TextStyle(
                      color: Colors.grey.withOpacity(.9), fontSize: 15),
                ),
                const SizedBox(
                  height: 25,
                ),
                OtpPinField(
                    fieldHeight: 45,
                    fieldWidth: 45,
                    maxLength: 6,
                    onSubmit: (String value) {
                   SignUpCubit.get(context).activateAccount(email: SignUpCubit.get(context).emailController.text
                       , token: value);
                    },
                    onChange: (String value) {},
                    otpPinFieldDecoration:
                    OtpPinFieldDecoration.roundedPinBoxDecoration,
                    otpPinFieldStyle: const OtpPinFieldStyle(
                        filledFieldBorderColor: ColorManager.primaryColor,
                        defaultFieldBorderColor: ColorManager.blackColor)),

                const SizedBox(
                  height: 30,
                ),
                const Text(
                  Strings.or,
                  style:
                      TextStyle(color: ColorManager.blackColor, fontSize: 12),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.loginScreen);
                  },
                  child: const Text(
                    Strings.emailActivated,
                    style: TextStyle(
                        color: ColorManager.primaryColor, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
