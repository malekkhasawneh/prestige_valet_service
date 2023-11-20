import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:prestige_valet_app/features/scan_qr_code/cubit/scan_qr_cubit.dart';

class ScanQrCodeScreen extends StatelessWidget {
  const ScanQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<ScanQrCubit, ScanQrState>(builder: (context, state) {
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
                    ScanQrCubit.get(context).scanQrCode();
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
