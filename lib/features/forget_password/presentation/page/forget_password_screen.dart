import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
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
                textInputType: TextInputType.emailAddress),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    backgroundColor: ColorManager.whiteColor,
                    elevation: 0.5),
                child: Text(
                  Strings.sendVerificationCode,
                  style: TextStyle(
                    color: ColorManager.blackColor,
                    fontFamily: Fonts.sourceSansPro,
                    fontSize: ProfileCubit.get(context).isTablet(screenWidth)
                        ? 16
                        : 14,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
