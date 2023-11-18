import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/cubit/add_credit_card_cubit.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/widgets/sign_up_button_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
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
                    controller: AddCreditCardCubit.get(context)
                        .expirationDateController,
                    title: '',
                    hintText: Strings.signUpFirstName,
                    textInputType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFieldWidget(
                    controller: AddCreditCardCubit.get(context).cvvController,
                    title: '',
                    hintText: Strings.signUpLastName,
                    textInputType: TextInputType.number,
                  ),
                ),
              ],
            ),
            TextFieldWidget(
              controller:
                  AddCreditCardCubit.get(context).cardHolderNameController,
              title: '',
              hintText: Strings.signUpPhoneNumber,
              textInputType: TextInputType.name,
            ),
            TextFieldWidget(
              controller:
                  AddCreditCardCubit.get(context).billingAddressController,
              title: '',
              hintText: Strings.signUpEmailAddress,
              textInputType: TextInputType.text,
            ),
            TextFieldWidget(
              controller: AddCreditCardCubit.get(context).cardNumberController,
              title: '',
              hintText: Strings.signUpPassword ,
              textInputType: TextInputType.number,
            ),
            const SizedBox(
              height: 25,
            ),
            const SignUpButtonWidget(),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                Strings.or,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.withOpacity(0.9),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
