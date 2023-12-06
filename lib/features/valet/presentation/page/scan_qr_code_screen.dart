import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart';

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

        }
      }
    }, builder: (context, state) {
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
              )
            ],
          ),
        ),
      );
    });
  }
}
