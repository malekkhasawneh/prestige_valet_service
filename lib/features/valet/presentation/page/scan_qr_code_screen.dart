// ignore_for_file: use_build_context_synchronously
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:prestige_valet_app/core/helpers/database_helper.dart';
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
import 'package:prestige_valet_app/features/valet/presentation/page/connect_printer_screen.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({super.key});

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  @override
  void initState() {
    ScanQrCubit.get(context)
        .getValetParkingHistory(HomeCubit.get(context).userModel.user.gate!.id);
    HomeCubit.get(context)
        . getAndCheckPendingPayments(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<ScanQrCubit, ScanQrState>(
        listener: (context, state) async {
      if (ScanQrCubit.get(context).shouldAcceptPayment) {
        AwesomeDialog(
          context: context,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          animType: AnimType.scale,
          dialogType: DialogType.info,
          body: const Center(
            child: Text(
              'There are pending payments please confirm them before',
              style: TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          btnOkOnPress: () {
            setState(() {
           HomeCubit.get(context).setIsLoading = true;
            });
          },
          btnOkColor: Colors.blue,
        ).show();
      }
      if (state is ScanQrLoaded) {
        if (state.parkedCarsModel.parkingStatus ==
            Constants.deliveredToGateKeeper) {
          DatabaseHelper.insertCachedValetParking(
              parkingId: state.parkedCarsModel.id.toString(),
              userId: state.parkedCarsModel.user!.id.toString(),
              valetId: HomeCubit.get(context).userModel.user.id.toString());
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
                notificationReceiver: Constants.toUserNotification,);
            ScanQrCubit.get(context).printQrCode(
                '${state.parkedCarsModel.user!.userUuid},${state.parkedCarsModel.user!.id}',
                state.parkedCarsModel.slotNumber.toString());
          } else {
            ScanQrCubit.get(context).printGuestQrCode(
                '${state.parkedCarsModel.guestName}${DateTime.now().microsecondsSinceEpoch},${state.parkedCarsModel.id}',
                state.parkedCarsModel.slotNumber.toString());
          }
        }
      } else if (state is RetrieveGuestCarLoadedError) {
        if(state.failure == Constants.internetFailure){
          Navigator.pushNamed(context, Routes.noInternetScreen);
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
            animType: AnimType.scale,
            dialogType: DialogType.info,
            body: Center(
              child: Text(
                'Please confirm receiving ${(await ScanQrCubit.get(context).getGuestPrice(valetId: HomeCubit.get(context).userModel.user.id)).price.toString()} ${(await ScanQrCubit.get(context).getGuestPrice(valetId: HomeCubit.get(context).userModel.user.id)).currency} from customer',
                style: const TextStyle(
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            btnOkOnPress: () {

              //Navigator.pop(context);
            },
            btnOkColor: Colors.blue)
            .show();
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
      return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if( HomeCubit.get(context).getIsLoading){
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ConnectPrinterScreen(),
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
                    onPressed: () async {
                      var result = await BarcodeScanner.scan();
                      if (result.rawContent.isNotEmpty) {
                        if (ScanQrCubit.get(context)
                            .valetParkingTypesList
                            .isNotEmpty) {
                          final isPopped = await Navigator.pushNamed(
                              context, Routes.selectGateTypeScreen);
                          if (isPopped == true &&
                              ScanQrCubit.get(context).selectedParkingId !=
                                  -1) {
                            ScanQrCubit.get(context).parkCar(
                                valetId:
                                    HomeCubit.get(context).userModel.user.id,
                                userId: int.parse(
                                    result.rawContent.split(',').last),
                                parkingTypeId:
                                    ScanQrCubit.get(context).selectedParkingId);
                          }
                        }
                      } else {
                        ScanQrCubit.get(context).parkCar(
                            valetId: HomeCubit.get(context).userModel.user.id,
                            userId:
                                int.parse(result.rawContent.split(',').last),
                            parkingTypeId: -1);
                      }
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
                        fontSize:
                            ProfileCubit.get(context).isTablet(screenWidth)
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
                      if (ScanQrCubit.get(context).connected) {
                        // ScanQrCubit.get(context).parkCar(
                        //   valetId: HomeCubit.get(context).userModel.user.id,
                        //   isGuest: true,
                        // );
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
                        fontSize:
                            ProfileCubit.get(context).isTablet(screenWidth)
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
                        fontSize:
                            ProfileCubit.get(context).isTablet(screenWidth)
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
    });
  }
}
