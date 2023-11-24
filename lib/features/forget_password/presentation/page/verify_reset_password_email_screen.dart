import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/login/presentation/widgets/social_login_row.dart';

class VerifyResetPasswordEmailScreen extends StatelessWidget {
  const VerifyResetPasswordEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Strings.enterVerificationCode,
              style:
                  TextStyle(color: Colors.grey.withOpacity(.9), fontSize: 15),
            ),
            const SizedBox(
              height: 25,
            ),
            OtpPinField(
                onSubmit: (String value) {
                  // Todo :: implement send verification code method
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
              Strings.resendCode,
              style: TextStyle(color: ColorManager.primaryColor, fontSize: 12),
            ),
            const SizedBox(
              height: 70,
            ),
            const Text(
              Strings.or,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SocialLoginRow(),
            const Text(
              Strings.doNotHaveAccount,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
