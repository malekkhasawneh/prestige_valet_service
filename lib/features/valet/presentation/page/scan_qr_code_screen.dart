import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:prestige_valet_app/features/valet/presentation/widgets/guest_qr_widget.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({super.key});

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
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
                    state.parkedCarsModel.user!.firstName),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GuestQrWidget(
                  screenHeight: screenHeight,
                  parkedCarsModel: state.parkedCarsModel,
                ),
              ),
            );
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
      }else if(state is ScanQrError){
        if(state.failure == Constants.internetFailure){
          Navigator.pushNamed(context, Routes.noInternetScreen);
        }
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
                  onPressed: () {
                    ScanQrCubit.get(context).parkCar(
                      valetId: HomeCubit.get(context).userModel.user.id,
                      isGuest: true,
                    );
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
}
