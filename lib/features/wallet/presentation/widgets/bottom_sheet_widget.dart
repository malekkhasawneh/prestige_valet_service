import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/cubit/add_credit_card_cubit.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/widgets/text_field_widget.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key, required this.card});

  final WalletModel card;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCreditCardCubit, AddCreditCardState>(
        builder: (context, state) {
      return SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.2,
          color: ColorManager.whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: AddCreditCardCubit.get(context).cvvController,
                title: Strings.cvv,
                textInputType: TextInputType.number,
                mustCheck: AddCreditCardCubit.get(context).mustCheck,
                maxLength: 3,
                errorText: Strings.textFieldError,
                onlyNumbers: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(Strings.cancel,
                          style: TextStyle(
                              fontSize: 12, color: ColorManager.blackColor))),
                  TextButton(
                      onPressed: () {
                        AddCreditCardCubit.get(context).setMustCheck = true;
                        if (AddCreditCardCubit.get(context).checkCvv()) {
                          WalletCubit.get(context).cardNumber = card.cardNumber;
                          WalletCubit.get(context).cardHolderName =
                              card.cardHolderName;
                          WalletCubit.get(context).month =
                              card.expiryDate.split('/').first;
                          WalletCubit.get(context).year =
                              card.expiryDate.split('/').last;
                          WalletCubit.get(context).cvv =
                              AddCreditCardCubit.get(context)
                                  .cvvController
                                  .text;
                          Navigator.of(context)
                            ..pop()
                            ..pop(true);
                        }
                      },
                      child: Text(
                        Strings.ok,
                        style: const TextStyle(
                            fontSize: 12, color: ColorManager.primaryColor),
                      )),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
