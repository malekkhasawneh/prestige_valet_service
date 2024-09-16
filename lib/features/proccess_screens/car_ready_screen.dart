// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/page/wallet_screen.dart';

import '../../core/resources/color_manager.dart';
import '../../core/resources/fonts.dart';
import '../../core/resources/strings.dart';

const String testAPIKey =
    "rDYwTe_g1kXVzpuGMQhkVgO0ReJH_Jb39AUTH42_DBkxcKu9jyNBNLNpHtS4zk8qZxNuQrvpd8Re-DUwZKUQM3fN7OcMtHpsyBuBT5DxyAcWxPmXoT0eLXXj4V-5whYhW6OkjcgZu08DDU8v0eY7vLM_XhT6vKXJZtwZ1onbpvwHxBzrIXVtX8P2rhTUczCu2chfBlhe7Agcy_5ES41qlxkigtRldg3Z_31W4NO-Dj6R4RNqh-ZJ1ocwTLX6Miw3bMUB_Kyf_NFaKRB4M2rpI50ywbF6mDrWSjSoa-yPt2WLRZ1FvyJluuIRBV_Stu24XZkgtUHDRGerNswMPHT4_j2Sbmm4bH3Wtqbsjx_k0yAhcxkItojv4gXiSaVajo0m_mdXiX9JeRHQgQ9tM_Gt5t_aFNmnZD7hilV7K4TzFaxshijLHAkES9Ou-yON5VAnA6JaXXRLJROUtqRVM_GXYExg-dXO5DMKoBtZ4Ze3JPcJvjSWO4GidumcbKH2UGZvbIdEPcXPPZOLMO3ufFVtN0M_eah4dR-Hs1vAXd2B3VKB8fyeNPEIfGEPGSpUViUHHZZXKsHV5lG3UX-nse5MaKLcGHVq4MtLKXxKljWL6cZrMYh5q1q05LlZcMPMwinZNeIT1suKEa_efjunm08BpBZ5oGP83TU2oJ4XWSP1ZvRKC_E_";

class CarReadyScreen extends StatefulWidget {
  const CarReadyScreen({super.key});

  @override
  State<CarReadyScreen> createState() => _CarReadyScreenState();
}

class _CarReadyScreenState extends State<CarReadyScreen> {
  @override
  void initState() {
    // DatabaseHelper.insertPayment(
    //     amount: BottomNavBarCubit.get(context).totalPrice.toString(),
    //     currency: BottomNavBarCubit.get(context).currency,
    //     valetId: BottomNavBarCubit.get(context).valetId.toString(),
    //     valetName: BottomNavBarCubit.get(context).valetName,
    //     gateName: PickUpCubit.get(context).gateName,
    //     retrieveCarModel:
    //         json.encode(BottomNavBarCubit.get(context).retrieveCarModel));
    initiate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log('============================================== isJordan ${ScanQrCubit.get(context).isJordanCurrency(BottomNavBarCubit.get(context).currency)}');
    double screenWidth = MediaQuery.of(context).size.width;
    mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());
    mfApplePayButton = MFApplePayButton(applePayStyle: MFApplePayStyle());
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is ExecutePaymentLoaded) {
          if (state.status) {
            WalletCubit.get(context).sendPayment(
                type: selectedPaymentMethodIndex == 8
                    ? 'CARD'
                    : selectedPaymentMethodIndex == 5
                        ? 'STC'
                        : 'CASH',
                amount: "5.0",
                currency: 'JOD',
                userId: 102,
                gateId: 1,
                parkingId: 502);
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
            HomeCubit.get(context).refreshAfterConnect = () {
              WalletCubit.get(context).sendPayment(
                  type: selectedPaymentMethodIndex == 8
                      ? 'CARD'
                      : selectedPaymentMethodIndex == 5
                          ? 'STC'
                          : 'CASH',
                  amount: '5.0',
                  currency: "JOD",
                  userId: 102,
                  gateId: 1,
                  parkingId: 502);
            };
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
        } else if (state is SendPaymentLoaded) {
          if (state.status) {
            BottomNavBarCubit.get(context).sendNotification(
              userId: BottomNavBarCubit.get(context).valetId,
              title: Strings.notificationTitle(
                  BottomNavBarCubit.get(context).valetName),
              body: Strings.payWithCashNotification(
                  BottomNavBarCubit.get(context).totalPrice.toString(),
                  BottomNavBarCubit.get(context).currency,
                  BottomNavBarCubit.get(context).parkingId),
              notificationType: Constants.cashPaymentValueNotificationAction,
              notificationReceiver: Constants.toValetNotification,
            );
            AwesomeDialog(
              context: context,
              animType: AnimType.topSlide,
              dialogType: DialogType.success,
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,
              body: Center(
                child: Text(
                  'Please pay 5.0 JOD to the valet attendant once you receive your car\n ',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              btnOkOnPress: () {
                Navigator.pushNamed(context, Routes.successScreen);
              },
            ).show();
          }
        } else if (state is SendPaymentError) {
          if (state.error == Constants.internetFailure) {
            HomeCubit.get(context).refreshAfterConnect = () {};
            Navigator.pushNamed(context, Routes.noInternetScreen);
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
                      Text('5.0 JOD'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  BottomNavBarCubit.get(context).washingPrice > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Wash car'),
                            Text(
                                '${BottomNavBarCubit.get(context).washingPrice} JD'),
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
                      'Total           5.0 JOD',
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
              bottom: ScanQrCubit.get(context)
                      .isJordanCurrency(BottomNavBarCubit.get(context).currency)
                  ? 80
                  : 135,
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
                    WalletCubit.get(context).sendPayment(
                      type: 'CASH',
                      amount: "5.0",
                      currency: "JOD",
                      userId: 102,
                      gateId: 1,
                      parkingId: 502,
                    );
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
            ScanQrCubit.get(context)
                    .isJordanCurrency(BottomNavBarCubit.get(context).currency)
                ? const SizedBox()
                : Positioned(
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
                              "5.0");
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
                          "5.0");
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

  String? response = '';
  MFInitiateSessionResponse? session;

  List<MFPaymentMethod> paymentMethods = [];
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = -1;

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
        response =
            "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token";
      });
      return;
    }

    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    await MFSDK.init(testAPIKey, MFCountry.JORDAN, MFEnvironment.LIVE);
    // (Optional) un comment the following lines if you want to set up properties of AppBar.
    if (Platform.isAndroid) {
      MFSDK.setUpActionBar(
          toolBarTitle: 'Prestige valet service',
          toolBarTitleColor: '#ffffffff',
          toolBarBackgroundColor: '#00000000',
          isShowToolBar: true);
    }

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
      response = json;
    });
  }

  // Send Payment
  sendPayment() async {
    var request = MFSendPaymentRequest(
        invoiceValue: 5.0,
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
        invoiceAmount: 5.0,
        currencyIso: !ScanQrCubit.get(context).isJordanCurrency("JOD")
            ? MFCurrencyISO.JORDAN_JOD
            : MFCurrencyISO.JORDAN_JOD);

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
    executePaymentRequest.displayCurrencyIso =
        !ScanQrCubit.get(context).isJordanCurrency("JOD")
            ? MFCurrencyISO.JORDAN_JOD
            : MFCurrencyISO.JORDAN_JOD;
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

  updateAmount() {
    if (Platform.isIOS) {
      MFApplepay.updateAmount(5.0);
    }
  }

  applePayPayment(MFInitiateSessionResponse session) async {
    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.displayCurrencyIso = !ScanQrCubit.get(context)
            .isJordanCurrency(BottomNavBarCubit.get(context).currency)
        ? MFCurrencyISO.JORDAN_JOD
        : MFCurrencyISO.JORDAN_JOD;

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
