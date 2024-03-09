import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';

class CancelButtonWidget extends StatelessWidget {
  const CancelButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return  Positioned(
      bottom: 30,
      child: Container(
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
            HomeCubit.get(context).cancelCarRetrieving(
                parkingId: HomeCubit.get(context).parkedCarModel.parking.id);
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
            Strings.cancel,
            style: TextStyle(
              color: ColorManager.blackColor,
              fontFamily: Fonts.sourceSansPro,
              fontSize:
              ProfileCubit.get(context).isTablet(screenWidth) ? 16 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
