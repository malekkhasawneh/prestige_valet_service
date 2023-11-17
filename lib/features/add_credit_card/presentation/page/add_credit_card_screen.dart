import 'package:flutter/material.dart';
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
                  controller:
                      AddCreditCardCubit.get(context).cardHolderNameController,
                  title: Strings.cardHolderName,
                  textInputType:TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  controller:
                      AddCreditCardCubit.get(context).billingAddressController,
                  title: Strings.billingAddress,
                  textInputType:TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  controller:
                      AddCreditCardCubit.get(context).cardNumberController,
                  title: Strings.cardNumber,
                  textInputType:TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: TextFieldWidget(
                        controller:
                            AddCreditCardCubit.get(context).expirationDateController,
                        title: Strings.expirationDate,
                        textInputType:TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: TextFieldWidget(
                        controller:
                        AddCreditCardCubit.get(context).cvvController,
                        title: Strings.cvv,
                        textInputType:TextInputType.number,
                      ),
                    ),
                  ],
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
  }
}
