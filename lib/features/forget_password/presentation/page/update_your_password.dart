import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/widget/save_new_password_button_widget.dart';

class UpdateYourPasswordScreen extends StatelessWidget {
  const UpdateYourPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoaded) {
          if (state.changePasswordModel.message ==
              Constants.resetPasswordSuccess) {
            AwesomeDialog(
              context: context,
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              animType: AnimType.scale,
              dialogType: DialogType.success,
              body: Center(
                child: Text(
                  '${state.changePasswordModel.message}\n ',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              btnOkOnPress: () {
                Navigator.pushReplacementNamed(context, Routes.loginScreen);
              },
            ).show();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.arrow_back),
            title: const Text(
              Strings.updateYourPasswordTitle,
              style: TextStyle(fontSize: 22),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              TextFieldWidget(
                title: Strings.enterPassword,
                hintText: Strings.enterPasswordHint,
                controller: ForgetPasswordCubit.get(context).passwordController,
                textInputType: TextInputType.visiblePassword,
                isPassword: true,
                mustCheck: ForgetPasswordCubit.get(context)
                    .passwordController
                    .text
                    .isEmpty,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                title: Strings.confirmPassword,
                hintText: Strings.confirmPasswordHint,
                controller:
                    ForgetPasswordCubit.get(context).confirmPasswordController,
                textInputType: TextInputType.visiblePassword,
                isPassword: true,
                mustCheck:
                    ForgetPasswordCubit.get(context).passwordController.text !=
                        ForgetPasswordCubit.get(context)
                            .confirmPasswordController
                            .text,
              ),
              const SizedBox(
                height: 50,
              ),
              const SaveNewPasswordButtonWidget(),
            ],
          ),
        );
      },
    );
  }
}
