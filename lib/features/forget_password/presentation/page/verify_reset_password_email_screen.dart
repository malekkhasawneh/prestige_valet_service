import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:prestige_valet_app/features/login/presentation/widgets/social_login_row.dart';

class VerifyResetPasswordEmailScreen extends StatelessWidget {
  const VerifyResetPasswordEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is VerifyOtpError) {
          AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: const Center(
              child: Text(
                'Wrong OTP\n ',
                style: TextStyle(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            btnOkOnPress: () {
              Navigator.popUntil(
                  context,
                  (route) =>
                      route.settings.name ==
                      Routes.verifyResetPasswordEmailScreen);
            },
            btnOkColor: Colors.red,
          ).show();
        } else if (state is VerifyOtpLoaded) {
          if (state.isVerified) {
            Navigator.pushNamed(context, Routes.updateYourPasswordScreen);
          }
        }
      },
      child: Scaffold(
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
                Strings.enterVerificationCode,
                style:
                    TextStyle(color: Colors.grey.withOpacity(.9), fontSize: 15),
              ),
              const SizedBox(
                height: 25,
              ),
              OtpPinField(
                  fieldHeight: 45,
                  fieldWidth: 45,
                  maxLength: 6,
                  onSubmit: (String value) {
                    ForgetPasswordCubit.get(context).verifyOtp(otp: value);
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
              GestureDetector(
                onTap: () {
                  ForgetPasswordCubit.get(context).sendResetPasswordOtp();
                },
                child: const Text(
                  Strings.resendCode,
                  style:
                      TextStyle(color: ColorManager.primaryColor, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
