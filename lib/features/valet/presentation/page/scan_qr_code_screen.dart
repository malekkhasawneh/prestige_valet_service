// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart';
import 'package:prestige_valet_app/screens/scan_screen.dart';
import 'package:prestige_valet_app/utils/snackbar.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({super.key});

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    ScanQrCubit.get(context).isPrinterConnected();
    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future onScanPressed() async {
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e),
          success: false);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<ScanQrCubit, ScanQrState>(listener: (context, state) {
      if (state is ScanQrLoaded) {
        if (state.parkedCarsModel.parkingStatus ==
            Constants.deliveredToGateKeeper) {
          ScanQrCubit.get(context)
              .changeParkedCarStatus(parkingId: state.parkedCarsModel.id);
        } else if (state.parkedCarsModel.parkingStatus == Constants.carParked) {
          if (!state.parkedCarsModel.isGuest) {
            BottomNavBarCubit.get(context).sendNotification(
                userId: state.parkedCarsModel.user!.id,
                title: Strings.notificationTitle(
                    state.parkedCarsModel.user!.firstName!),
                body: Strings.userCarParked,
                notificationType: Constants.carParkedNotificationAction,
                notificationReceiver: Constants.toUserNotification);
            AwesomeDialog(
              context: context,
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              animType: AnimType.scale,
              dialogType: DialogType.success,
              body: Center(
                child: Text(
                  "${state.parkedCarsModel.user!.firstName}'s car has been parked successfully\n ",
                  style: const TextStyle(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              btnOkOnPress: () {},
              btnOkColor: Colors.green,
            ).show();
          } else {
            ScanQrCubit.get(context).printGraphics(
                '${state.parkedCarsModel.guestName}${DateTime.now().microsecondsSinceEpoch},${state.parkedCarsModel.id}');
          }
        }
      } else if (state is RetrieveGuestCarLoadedError) {
        if(state.failure == Constants.internetFailure){
          Navigator.pushNamed(context, Routes.noInternetScreen);
        }else if(state.failure == Constants.serverFailure){
          Navigator.pushReplacementNamed(context, Routes.loginScreen);
        }else {
          AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: Center(
              child: Text(
                '${state.failure}\n ',
                style: const TextStyle(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            btnOkOnPress: () {},
            btnOkColor: Colors.red,
          ).show();
        }
      } else if (state is RetrieveGuestCarLoaded) {
        AwesomeDialog(
          context: context,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          body: const Center(
            child: Text(
              'Process Completed Successfully\n ',
              style: TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          btnOkOnPress: () {},
          btnOkColor: Colors.green,
        ).show();
      } else if (state is ScanQrError) {
        if (state.failure == Constants.internetFailure) {
          Navigator.pushNamed(context, Routes.noInternetScreen);
        }
      } else if (state is PrinterNotConnectedError) {
        AwesomeDialog(
          context: context,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          body: Center(
            child: Text(
              '${state.failure}\n ',
              style: const TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      }
    }, builder: (context, state) {
      if (state is ScanQrLoading) {
        return const Padding(
          padding: EdgeInsets.only(top: 56),
          child: Center(
            child: CircularProgressIndicator(
              color: ColorManager.primaryColor,
            ),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.transparent,
          title: Text(
              'Printer : ${ScanQrCubit.get(context).connected ? 'Connected to ${ScanQrCubit.get(context).connectedDeviceName}' : 'Not connected'}',
              style: const TextStyle(fontSize: 12)),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () async {
                  await onScanPressed();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ScanScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.print,
                  color: ColorManager.primaryColor,
                ),
              ),
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                Images.qrCodeScanner,
                width: screenWidth * 0.6,
                height: screenHeight * .5,
              ),
              Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.065,
                constraints: const BoxConstraints(maxHeight: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorManager.blackColor,
                    )),
                child: ElevatedButton(
                  onPressed: () {
                    ScanQrCubit.get(context).parkCar(
                        valetId: HomeCubit.get(context).userModel.user.id);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      backgroundColor: ColorManager.whiteColor,
                      elevation: 0.5),
                  child: Text(
                    Strings.scanQrCode,
                    style: TextStyle(
                      color: ColorManager.blackColor,
                      fontFamily: Fonts.montserrat,
                      fontSize: ProfileCubit.get(context).isTablet(screenWidth)
                          ? 16
                          : 14,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: screenWidth * 0.85,
                height: screenHeight * 0.065,
                constraints: const BoxConstraints(maxHeight: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    await ScanQrCubit.get(context)
                        .isPrinterConnected()
                        .then((_) {
                      if (ScanQrCubit.get(context).connected) {
                        ScanQrCubit.get(context).parkCar(
                          valetId: HomeCubit.get(context).userModel.user.id,
                          isGuest: true,
                        );
                      } else {
                        AwesomeDialog(
                          context: context,
                          dismissOnBackKeyPress: false,
                          dismissOnTouchOutside: false,
                          animType: AnimType.scale,
                          dialogType: DialogType.error,
                          body: const Center(
                            child: Text(
                              'No connected printer\n ',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          btnOkOnPress: () {},
                          btnOkColor: Colors.red,
                        ).show();
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      backgroundColor: ColorManager.primaryColor,
                      elevation: 0.5),
                  child: Text(
                    Strings.generateQrCode,
                    style: TextStyle(
                      color: ColorManager.whiteColor,
                      fontFamily: Fonts.montserrat,
                      fontSize: ProfileCubit.get(context).isTablet(screenWidth)
                          ? 16
                          : 14,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: screenWidth * 0.85,
                height: screenHeight * 0.065,
                constraints: const BoxConstraints(maxHeight: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    ScanQrCubit.get(context).retrieveGuestCar();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      backgroundColor: ColorManager.blackColor,
                      elevation: 0.5),
                  child: Text(
                    Strings.retrieveGuestCar,
                    style: TextStyle(
                      color: ColorManager.whiteColor,
                      fontFamily: Fonts.montserrat,
                      fontSize: ProfileCubit.get(context).isTablet(screenWidth)
                          ? 16
                          : 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }
}
