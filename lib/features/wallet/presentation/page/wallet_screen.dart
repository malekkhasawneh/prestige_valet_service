import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/widgets/add_payment_method_widget.dart';
import 'package:prestige_valet_app/features/wallet/presentation/widgets/bottom_sheet_widget.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
      child: BlocConsumer<WalletCubit, WalletState>(listener: (context, state) {
        if (state is ExecutePaymentLoaded) {
          if (state.status) {
            AwesomeDialog(
              context: context,
              animType: AnimType.topSlide,
              dialogType: DialogType.success,
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,
              body: const Center(
                child: Text(
                  'Payment done successfully\n ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              btnOkOnPress: () {
                Navigator.pushNamed(context, Routes.successScreen);
              },
            ).show();
          } else {
            AwesomeDialog(
                    context: context,
                    animType: AnimType.topSlide,
                    dialogType: DialogType.error,
                    dismissOnTouchOutside: false,
                    dismissOnBackKeyPress: false,
                    body: const Center(
                      child: Text(
                        'The payment can not be completed at this time.\nPlease try again later\n ',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    btnOkOnPress: () {
                      Navigator.pop(context);
                    },
                    btnOkColor: Colors.red)
                .show();
          }
        } else if (state is ExecutePaymentError) {
          if (state.error == Constants.paymentInternetError) {
            HomeCubit.get(context).refreshAfterConnect = () {};
            Navigator.pushNamed(context, Routes.noInternetScreen);
          } else {
            AwesomeDialog(
                    context: context,
                    animType: AnimType.topSlide,
                    dialogType: DialogType.error,
                    dismissOnTouchOutside: false,
                    dismissOnBackKeyPress: false,
                    body: const Center(
                      child: Text(
                        'The payment can not be completed at this time.\nPlease try again later\n ',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    btnOkOnPress: () {
                      Navigator.pop(context);
                    },
                    btnOkColor: Colors.red)
                .show();
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: widget.isPaymentMethod
                ? GestureDetector(
                    onTap: () {
                      Navigator.pop(context, false);
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
          body: SingleChildScrollView(
            child: Stack(
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
                                          ? () async {
                                              showModalBottomSheet(
                                                  isDismissible: false,
                                                  context: context,
                                                  builder: (context) =>
                                                      BottomSheetWidget(
                                                        card:
                                                            state.model[index],
                                                      ));
                                            }
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
          ),
        );
      }),
    );
  }
}
