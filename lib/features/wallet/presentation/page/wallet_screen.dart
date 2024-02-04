import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/widgets/add_payment_method_widget.dart';
import 'package:prestige_valet_app/features/wallet/presentation/widgets/credit_card_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({
    super.key,
    this.isPaymentMethod = false,
    this.isFromPayScreen = false,
  });

  final bool isPaymentMethod;
  final bool isFromPayScreen;

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    WalletCubit.get(context).getCards();
    if (widget.isFromPayScreen) {
      //initiate();
    }
    super.initState();
  }
  //
  // initiate() async {
  //   await MFSDK.init(dotenv.env[Constants.myFatoorahToken]!,
  //       MFCountry.SAUDIARABIA, MFEnvironment.TEST);
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<WalletCubit, WalletState>(listener: (context, state) {
      if (state is ExecutePaymentLoaded) {
        if (state.model.cardInfoResponse!.status == Constants.paymentSuccess) {
          Navigator.pushReplacementNamed(context, Routes.successScreen);
        } else {
          Navigator.pop(context);
        }
      } else if (state is WalletError) {
        if (state.failure == Constants.internetFailure) {
          HomeCubit.get(context).refreshAfterConnect = () {
            if (widget.isFromPayScreen) {
              //initiate();
            }
          };
          Navigator.pushNamed(context, Routes.noInternetScreen);
        }else if(state.failure == Constants.serverFailure){
          Navigator.pushReplacementNamed(context, Routes.loginScreen);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: widget.isPaymentMethod
              ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: ColorManager.whiteColor,
                  ),
                )
              : const SizedBox(),
          backgroundColor: ColorManager.transparent,
        ),
        extendBodyBehindAppBar: true,
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
                    child: Text(
                      Strings.carParkedHiString(
                          HomeCubit.get(context).userModel.user.firstName),
                      style: const TextStyle(
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
                      child: state.model.isNotEmpty
                          ? ListView.builder(
                        padding: const EdgeInsets.only(top: 25),
                              itemCount: state.model.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: widget.isFromPayScreen
                                      ? () async {}
                                : null,
                            child: CreditCardWidget(
                              walletModel: state.model[index],
                              isPaymentMethod: widget.isPaymentMethod,
                            ),
                          );
                        },
                            )
                          : SizedBox(
                              height: WalletCubit.get(context)
                                  .bodyBoxHeight(context, screenHeight),
                              child: const Center(
                                  child: Text(
                                Strings.thereAreNoData,
                              )),
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
            AddPaymentMethodWidget(
              isPaymentMethod: widget.isPaymentMethod,
            ),
          ],
        ),
      );
    });
  }
}
