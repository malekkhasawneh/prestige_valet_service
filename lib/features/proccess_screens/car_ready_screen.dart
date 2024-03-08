// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/page/wallet_screen.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/fonts.dart';
import '../../core/resources/strings.dart';

const String testAPIKey =
    "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

class CarReadyScreen extends StatefulWidget {
  const CarReadyScreen({super.key});

  @override
  State<CarReadyScreen> createState() => _CarReadyScreenState();
}

class _CarReadyScreenState extends State<CarReadyScreen> {
  int totalPrice = 0;
  int parkingPrice = 0;

  @override
  void initState() {
    getValues();
    initiate();
    super.initState();
  }

  getValues() async {
    parkingPrice = int.parse(await CacheHelper.getValue(
      key: 'parkingPrice',
    ));
    totalPrice = int.parse(await CacheHelper.getValue(
      key: 'totalPrice',
    ));
    setState(() {
      amount = '5.0';
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());
    mfApplePayButton = MFApplePayButton(applePayStyle: MFApplePayStyle());
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
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
                    btnOkOnPress: () {},
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
                    btnOkOnPress: () {},
                    btnOkColor: Colors.red)
                .show();
          }
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Positioned(
              top: 40,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: ColorManager.blackColor,
                      size: 120,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      Strings.carReady,
                      style: TextStyle(
                          fontFamily: Fonts.sourceSansPro,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: ColorManager.blackColor.withOpacity(.4),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Service',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: ColorManager.blackColor.withOpacity(.4),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Parking'),
                      Text('${HomeCubit.get(context).parkingPrice} JD'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  HomeCubit.get(context).washingPrice > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Wash car'),
                            Text('${HomeCubit.get(context).washingPrice} JD'),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: ColorManager.blackColor.withOpacity(.4),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Total           ${HomeCubit.get(context).totalPrice} JD',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 125,
              child: SizedBox(
                width: screenWidth * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    backgroundColor: ColorManager.whiteColor,
                    elevation: 0.2,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.successScreen);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.money,
                        color: ColorManager.blackColor,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        Strings.payWithCash,
                        style: TextStyle(
                          color: ColorManager.blackColor,
                          fontFamily: Fonts.sourceSansPro,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              child: SizedBox(
                width: screenWidth * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    backgroundColor: ColorManager.whiteColor,
                    elevation: 0.2,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedPaymentMethodIndex = 5;
                    });
                    WalletCubit.get(context).executeRegularPayment(
                        paymentMethods[selectedPaymentMethodIndex]
                            .paymentMethodId!,
                        amount);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.money,
                        color: ColorManager.blackColor,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        Strings.payWithSTC,
                        style: TextStyle(
                          color: ColorManager.blackColor,
                          fontFamily: Fonts.sourceSansPro,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              child: SizedBox(
                width: screenWidth * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    backgroundColor: ColorManager.whiteColor,
                    elevation: 0.2,
                  ),
                  onPressed: () async {
                    setState(() {
                      selectedPaymentMethodIndex = 8;
                    });
                    final bool isPop = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WalletScreen(
                          isFromPayScreen: true,
                          isPaymentMethod: true,
                        ),
                      ),
                    );
                    if (isPop) {
                      WalletCubit.get(context).executeDirectPayment(
                          paymentMethods[selectedPaymentMethodIndex]
                              .paymentMethodId!,
                          false,
                          amount);
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.money,
                        color: ColorManager.blackColor,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        Strings.payWithCard,
                        style: TextStyle(
                          color: ColorManager.blackColor,
                          fontFamily: Fonts.sourceSansPro,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _response = '';
  MFInitiateSessionResponse? session;

  List<MFPaymentMethod> paymentMethods = [];
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = 8;

  String cardNumber = "5453010000095489";
  String expiryMonth = "05";
  String expiryYear = "21";
  String securityCode = "100";
  String cardHolderName = "Test Account";

  String amount = "5.0";
  bool visibilityObs = false;

  late MFCardPaymentView mfCardView;
  late MFApplePayButton mfApplePayButton;

  @override
  void dispose() {
    super.dispose();
  }

  initiate() async {
    if (testAPIKey.isEmpty) {
      setState(() {
        _response =
            "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token";
      });
      return;
    }

    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    await MFSDK.init(testAPIKey, MFCountry.SAUDIARABIA, MFEnvironment.TEST);
    // (Optional) un comment the following lines if you want to set up properties of AppBar.
    MFSDK.setUpActionBar(
        toolBarTitle: 'Prestige valet service',
        toolBarTitleColor: '#ffffffff',
        toolBarBackgroundColor: '#ffffffff',
        isShowToolBar: true);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initSession();
      await initiatePayment();
      // await initiateSession();
    });
  }

  log(Object object) {
    var json = const JsonEncoder.withIndent('  ').convert(object);
    setState(() {
      debugPrint(json);
      _response = json;
    });
  }

  // Send Payment
  sendPayment() async {
    var request = MFSendPaymentRequest(
        invoiceValue: double.parse(amount),
        customerName: "Customer name",
        notificationOption: MFNotificationOption.LINK);
    // var invoiceItem = MFInvoiceItem(itemName: "item1", quantity: 1, unitPrice: 1);
    // request.invoiceItems = [invoiceItem];

    await MFSDK
        .sendPayment(request, MFLanguage.ENGLISH)
        .then((value) => log('the value : ' '$value'))
        .catchError((error) => {log(error)});
  }

  // Initiate Payment
  initiatePayment() async {
    var request = MFInitiatePaymentRequest(
        invoiceAmount: double.parse(amount),
        currencyIso: MFCurrencyISO.SAUDIARABIA_SAR);

    await MFSDK
        .initiatePayment(request, MFLanguage.ENGLISH)
        .then((value) => {
              log('the value : 2' '$value'),
              paymentMethods.addAll(value.paymentMethods!),
              for (int i = 0; i < paymentMethods.length; i++)
                isSelected.add(false)
            })
        .catchError((error) => {log(error.message)});
  }

  // Execute Regular Payment

  //Execute Direct Payment

  // Payment Enquiry
  getPaymentStatus() async {
    MFGetPaymentStatusRequest request =
        MFGetPaymentStatusRequest(key: '1515410', keyType: MFKeyType.INVOICEID);

    await MFSDK
        .getPaymentStatus(request, MFLanguage.ENGLISH)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // Cancel Token
  cancelToken() async {
    await MFSDK
        .cancelToken("Put your token here", MFLanguage.ENGLISH)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // Cancel Recurring Payment
  cancelRecurringPayment() async {
    await MFSDK
        .cancelRecurringPayment("Put RecurringId here", MFLanguage.ENGLISH)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  setPaymentMethodSelected(int index, bool value) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = value;
        if (value) {
          selectedPaymentMethodIndex = index;
          visibilityObs = paymentMethods[index].isDirectPayment!;
        } else {
          selectedPaymentMethodIndex = -1;
          visibilityObs = false;
        }
      } else {
        isSelected[i] = false;
      }
    }
  }

  MFCardViewStyle cardViewStyle() {
    MFCardViewStyle cardViewStyle = MFCardViewStyle();
    cardViewStyle.cardHeight = 200;
    cardViewStyle.hideCardIcons = false;
    cardViewStyle.input?.inputMargin = 3;
    cardViewStyle.label?.display = true;
    cardViewStyle.input?.fontFamily = MFFontFamily.TimesNewRoman;
    cardViewStyle.label?.fontWeight = MFFontWeight.Light;
    return cardViewStyle;
  }

  initSession() async {
    /*
      If you want to use saved card option with embedded payment, send the parameter
      "customerIdentifier" with a unique value for each customer. This value cannot be used
      for more than one Customer.
     */
    // var request = MFInitiateSessionRequest("12332212");
    /*
      If not, then send null like this.
     */
    MFInitiateSessionRequest initiateSessionRequest =
        MFInitiateSessionRequest();

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) => loadEmbeddedPayment(value))
        .catchError((error) => {log(error.message)});
  }

  loadCardView(MFInitiateSessionResponse session) {
    mfCardView.load(session, (bin) {
      log(bin);
    });
  }

  loadEmbeddedPayment(MFInitiateSessionResponse session) async {
    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;
    await loadCardView(session);
    if (Platform.isIOS) {
      applePayPayment(session);
      MFApplepay.setupApplePay(
          session, executePaymentRequest, MFLanguage.ENGLISH);
    }
  }

  openPaymentSheet() {
    if (Platform.isIOS) {
      MFApplepay.executeApplePayPayment()
          .then((value) => log(value))
          .catchError((error) => {log(error.message)});
    }
  }

  updateAmounnt() {
    if (Platform.isIOS) MFApplepay.updateAmount(double.parse(amount));
  }

  applePayPayment(MFInitiateSessionResponse session) async {
    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;

    await mfApplePayButton
        .displayApplePayButton(
            session, executePaymentRequest, MFLanguage.ENGLISH)
        .then((value) => {
              log(value),
              mfApplePayButton
                  .executeApplePayButton(null, (invoiceId) => log(invoiceId))
                  .then((value) => log(value))
                  .catchError((error) => {log(error.message)})
            })
        .catchError((error) => {log(error.message)});
  }

  initiateSession() async {
    /*
      If you want to use saved card option with embedded payment, send the parameter
      "customerIdentifier" with a unique value for each customer. This value cannot be used
      for more than one Customer.
     */
    // var request = MFInitiateSessionRequest("12332212");
    /*
      If not, then send null like this.
     */
    MFInitiateSessionRequest initiateSessionRequest =
        MFInitiateSessionRequest();
    await MFSDK
        .initiateSession(initiateSessionRequest, (bin) {
          log(bin);
        })
        .then((value) => {log(value)})
        .catchError((error) => {log(error.message)});
  }

  pay() async {
    var executePaymentRequest = MFExecutePaymentRequest(invoiceValue: 10);

    await mfCardView
        .pay(executePaymentRequest, MFLanguage.ENGLISH, (invoiceId) {
          debugPrint("-----------$invoiceId------------");
          log(invoiceId);
        })
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  validate() async {
    await mfCardView
        .validate()
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }
}
