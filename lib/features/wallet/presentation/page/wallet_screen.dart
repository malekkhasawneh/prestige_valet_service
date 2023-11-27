import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/widgets/add_payment_method_widget.dart';
import 'package:prestige_valet_app/features/wallet/presentation/widgets/credit_card_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    WalletCubit.get(context)
        .getCards(userId: HomeCubit.get(context).userModel.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
      return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: WalletCubit.get(context)
                      .headerBoxHeight(context, screenHeight),
                  width: screenWidth,
                  color: ColorManager.primaryColor,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      top: WalletCubit.get(context)
                              .headerBoxHeight(context, screenHeight) *
                          0.35,
                    ),
                    child: const Text(
                      Strings.walletHiString,
                      style: TextStyle(
                          fontFamily: Fonts.sourceSansPro,
                          fontSize: 26,
                          color: ColorManager.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (state is WalletLoaded) ...[
                  SizedBox(
                    height: WalletCubit.get(context)
                        .bodyBoxHeight(context, screenHeight),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.13, vertical: 0),
                      child: ListView.builder(
                        itemCount: state.model.length,
                        itemBuilder: (context, index) {
                          return CreditCardWidget(
                            name: state.model[index].cardHolderName.trim(),
                            cardNumber: state.model[index].cardNumber,
                          );
                        },
                      ),
                    ),
                  ),
                ] else ...[
                  SizedBox(
                    height: WalletCubit.get(context)
                        .bodyBoxHeight(context, screenHeight),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primaryColor,
                      ),
                    ),
                  )
                ]
              ],
            )),
            const AddPaymentMethodWidget(),
          ],
        ),
      );
    });
  }
}
