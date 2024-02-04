import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/cubit/add_credit_card_cubit.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/page/add_credit_card_screen.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
    required this.walletModel,
    required this.isPaymentMethod,
  });

  final WalletModel walletModel;
  final bool isPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xffF0F0F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.creditCardOverView,
                      style: TextStyle(
                        fontFamily: Fonts.sourceSansPro,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      walletModel.cardHolderName,
                      style: const TextStyle(
                        fontFamily: Fonts.sourceSansPro,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(Strings.creditCardNumber(walletModel.cardNumber)),
              ],
            ),
          ),
           Positioned(
            top: 5,
            right: 0,
            child: GestureDetector(
              onTap: () {
                AddCreditCardCubit.get(context).cardHolderNameController.text =
                    walletModel.cardHolderName;
                AddCreditCardCubit.get(context).cardNumberController.text =
                    walletModel.cardNumber;
                AddCreditCardCubit.get(context).expirationDateController.text =
                    walletModel.expiryDate;
                AddCreditCardCubit.get(context).walletId = walletModel.id;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddCreditCardScreen(
                      isFromEdit: true,
                    ),
                  ),
                );
              },
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: ColorManager.blackColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: isPaymentMethod
                      ? const SizedBox(
                          width: 12,
                        )
                      : const Icon(
                          Icons.edit,
                          color: ColorManager.whiteColor,
                          size: 12,
                        ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 13,
            right: 0,
            child: Icon(
              Icons.credit_card,
              color: ColorManager.primaryColor,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }
}
