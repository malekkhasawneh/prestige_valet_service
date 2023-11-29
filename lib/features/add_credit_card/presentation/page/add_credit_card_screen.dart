import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/cubit/add_credit_card_cubit.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/add_card_button_widget.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';

class AddCreditCardScreen extends StatelessWidget {
  const AddCreditCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCreditCardCubit, AddCreditCardState>(
        listener: (context, state) {
      if (state is AddCreditCardLoaded) {
        AwesomeDialog(
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.success,
          body: Center(
            child: Text(
              '${state.addCardModel.message}\n ',
              style: const TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          btnOkOnPress: () {},
        ).show();
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.transparent,
          elevation: 0,
          title: const Text(
            Strings.addCreditCard,
            style: TextStyle(
              fontFamily: Fonts.sourceSansPro,
              fontSize: 26,
              color: ColorManager.blackColor,
            ),
          ),
          leading: const Icon(
            Icons.arrow_back,
            color: ColorManager.blackColor,
            size: 30,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                    ),
                    child: const Icon(
                      Icons.credit_card,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFieldWidget(
                    controller: AddCreditCardCubit.get(context)
                        .cardHolderNameController,
                    title: Strings.cardHolderName,
                    textInputType: TextInputType.name,
                    mustCheck: AddCreditCardCubit.get(context)
                        .checkIfThereAreEmptyField(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    controller:
                        AddCreditCardCubit.get(context).cardNumberController,
                    title: Strings.cardNumber,
                    textInputType: TextInputType.number,
                    mustCheck: AddCreditCardCubit.get(context)
                        .checkIfThereAreEmptyField(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    controller: AddCreditCardCubit.get(context)
                        .expirationDateController,
                    title: Strings.expirationDate,
                    textInputType: TextInputType.number,
                    mustCheck: AddCreditCardCubit.get(context)
                        .checkIfThereAreEmptyField(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const AddCardButtonWidget(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
