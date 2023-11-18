import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/widget/save_new_password_button_widget.dart';

class UpdateYourPasswordScreen extends StatelessWidget {
  const UpdateYourPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      appBar: AppBar(
      leading: const Icon(Icons.arrow_back),
      title: const Text(
        Strings.updateYourPasswordTitle,
        style: TextStyle(fontSize: 22),
      ),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50,),
        TextFieldWidget(
          title: Strings.email,
          hintText: Strings.emailHint,
          controller: ForgetPasswordCubit.get(context).passwordController,
          textInputType: TextInputType.emailAddress,
          isPassword: true,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFieldWidget(
          title: Strings.password,
          hintText: Strings.passwordHint,
          controller: ForgetPasswordCubit.get(context).confirmPasswordController,
          textInputType: TextInputType.visiblePassword,
          isPassword: true,
        ),
        const SizedBox(height: 50,),
        const SaveNewPasswordButtonWidget(),
      ],
    ),);
  }
}
