import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/helpers/notification_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/cubit/pick_up_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';

class ConfirmButtonWidget extends StatelessWidget {
  const ConfirmButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) async {
        if (state is RetrieveCarLoaded) {
          if (state.parkedCarsModel.parkingStatus ==
              Constants.carInRetrieving) {
            log('=================================== parking ${state.parkedCarsModel.parkingPrice}');
            log('=================================== parking ${state.parkedCarsModel.totalPrice}');
            HomeCubit.get(context).parkingPrice = state.parkedCarsModel.parkingPrice;
            HomeCubit.get(context).totalPrice = state.parkedCarsModel.totalPrice;
            BottomNavBarCubit.get(context).sendNotification(
                userId: state.parkedCarsModel.valet!.id.toInt(),
                title: Strings.notificationTitle(
                    state.parkedCarsModel.valet!.firstName),
                body: Strings.valetCarRetrievingRequest(
                    state.parkedCarsModel.user!.firstName),
                notificationType: Constants.carInRetrievingNotificationAction,
                notificationReceiver: Constants.toValetNotification);
            NotificationHelper.sendLocalNotification(
                title: Strings.notificationTitle(
                    state.parkedCarsModel.user!.firstName),
                body: Strings.userCarRetrievingRequest);
            HomeCubit.get(context).setSetGate = false;
            HomeCubit.get(context).isUserCarParked = false;
            HomeCubit.get(context).setIsUserCarInRetrieve = true;
            BottomNavBarCubit.get(context).retrieveCarModel =
                state.parkedCarsModel;
            state.parkedCarsModel.gateId =
                PickUpCubit.get(context).selectedGateId;
            await CacheHelper.setValue(
              key: CacheConstants.retrievedCarModel,
              value: json.encode(
                state.parkedCarsModel.toJson(),
              ),
            );
          }
        }
      },
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
            HomeCubit.get(context).retrieveCar(
                parkingId: HomeCubit.get(context).parkedCarModel.parking.id,
                gateId: PickUpCubit.get(context).selectedGateId);
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
            Strings.confirm,
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
