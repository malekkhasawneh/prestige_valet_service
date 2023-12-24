import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/helpers/notification_helper.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/widget/qr_code_widget.dart';
import 'package:prestige_valet_app/features/home/presentation/widget/request_car_widget.dart';
import 'package:prestige_valet_app/features/home/presentation/widget/show_your_history_widget.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/page/pick_up_screen.dart';

class CarParkedHomeScreen extends StatelessWidget {
  const CarParkedHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is WashCarLoaded) {
        BottomNavBarCubit.get(context).sendNotification(
            userId: HomeCubit.get(context).parkedCarModel.valet.id,
            title: Strings.notificationTitle(
                HomeCubit.get(context).parkedCarModel.valet.firstName),
            body: Strings.valetCarWashingRequest(
                HomeCubit.get(context).parkedCarModel.user!.firstName),
            notificationType: Constants.carWashNotificationAction,
            notificationReceiver: Constants.toValetNotification);
        NotificationHelper.sendLocalNotification(
            title: Strings.notificationTitle(
                HomeCubit.get(context).parkedCarModel.user!.firstName),
            body: Strings.userCarWashRequest);
      } else if (state is RetrieveCarLoaded) {
        HomeCubit.get(context).setIsUserCarInRetrieve = true;
      } else if (state is HomeError) {
        if (state.failure == Constants.internetFailure) {
          Navigator.pushNamed(context, Routes.noInternetScreen);
        }
      }
    }, builder: (context, state) {
      return HomeCubit.get(context).setGate
          ? const PickUpScreen()
          : Scaffold(
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: HomeCubit.get(context)
                            .headerBoxHeight(context, screenHeight),
                        width: screenWidth,
                        color: ColorManager.primaryColor,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.05,
                            top: HomeCubit.get(context)
                                    .headerBoxHeight(context, screenHeight) *
                                0.35,
                          ),
                          child: Text(
                            Strings.carParkedHiString(HomeCubit.get(context)
                                .userModel
                                .user
                                .firstName),
                            style: const TextStyle(
                                fontFamily: Fonts.sourceSansPro,
                                fontSize: 26,
                                color: ColorManager.whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: HomeCubit.get(context)
                            .bodyBoxHeight(context, screenHeight),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: HomeCubit.get(context).bodyBoxHeight(
                                          context, screenHeight) *
                                      0.2,
                                ),
                                QrCodeWidget(
                                  screenHeight: screenHeight,
                                ),
                                SizedBox(
                                  height: HomeCubit.get(context).bodyBoxHeight(
                                          context, screenHeight) *
                                      0.03,
                                ),
                                const Text(
                                  Strings.uniqueId,
                                  style: TextStyle(
                                    fontFamily: Fonts.sourceSansPro,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  HomeCubit.get(context)
                                      .userModel
                                      .user
                                      .userId
                                      .split('-')
                                      .first,
                                  style: const TextStyle(
                                    fontFamily: Fonts.sourceSansPro,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: HomeCubit.get(context)
                                      .bodyBoxHeight(context, screenHeight) *
                                  0.1,
                            ),
                            const ShowYourHistoryWidget()
                          ],
                        ),
                      ),
                    ],
                  )),
                  const RequestCarWidget(),
                ],
              ),
            );
    });
  }
}
