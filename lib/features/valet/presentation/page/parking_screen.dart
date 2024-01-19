import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart';
import 'package:prestige_valet_app/features/valet/presentation/widgets/parking_card_widget.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  @override
  void initState() {
    ScanQrCubit.get(context)
        .getValetHistory(valetId: HomeCubit.get(context).userModel.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<ScanQrCubit, ScanQrState>(listener: (context, state) {
      if (state is ScanQrLoaded) {
        log('======================= user id ${state.parkedCarsModel.user!.id}');
        log('======================= valet id ${state.parkedCarsModel.valet.id}');
        BottomNavBarCubit.get(context).sendNotification(
            userId: state.parkedCarsModel.user!.id,
            title: Strings.notificationTitle(
                state.parkedCarsModel.user!.firstName!),
            body: Strings.userCarRetrieving,
            notificationType: Constants.carDeliveredNotificationAction,
            notificationReceiver: Constants.toUserNotification);
        ScanQrCubit.get(context).getValetHistory(
          valetId: state.parkedCarsModel.valet.id,
          canLoading: false,
        );
      } else if (state is RetrieveGuestCarLoadedError) {
        if (state.failure == Constants.internetFailure) {
          HomeCubit.get(context).refreshAfterConnect = () {
            ScanQrCubit.get(context)
                .getValetHistory(valetId: HomeCubit.get(context).userModel.user.id);
          };
          Navigator.pushNamed(context, Routes.noInternetScreen);
        } else {
          ScanQrCubit.get(context)
              .getValetHistory(valetId: HomeCubit
              .get(context)
              .userModel
              .user
              .id);

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
      }else if(state is ScanQrError){
        if(state.failure == Constants.internetFailure){
          Navigator.pushNamed(context, Routes.noInternetScreen);
        }
      } }, builder: (context, state) {
      return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: WalletCubit.get(context)
                        .headerBoxHeight(context, screenHeight),
                    width: screenWidth,
                    color: ColorManager.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.05,
                        top: WalletCubit.get(context)
                            .headerBoxHeight(context, screenHeight) *
                            0.35,
                      ),
                      child: Text(
                        Strings.parkingHiString(
                            HomeCubit.get(context).userModel.user.firstName),
                        style: const TextStyle(
                            fontFamily: Fonts.sourceSansPro,
                            fontSize: 26,
                            color: ColorManager.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  if (state is GetValetHistoryLoaded) ...[
                    SizedBox(
                      height: WalletCubit.get(context)
                          .bodyBoxHeight(context, screenHeight),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.13, vertical: 0),
                        child: state.valetHistoryModel.content.isNotEmpty
                            ? ListView.builder(
                          itemCount:
                          state.valetHistoryModel.content.length,
                          itemBuilder: (context, index) {
                            return ParkingCardWidget(
                              phone: state.valetHistoryModel
                                  .content[index].isGuest
                                  ? ''
                                  : state.valetHistoryModel.content[index]
                                  .user!.phone,
                              imageUrl: state.valetHistoryModel
                                  .content[index].isGuest
                                  ? ''
                                  : state.valetHistoryModel.content[index]
                                  .user!.profileImg,
                              name: state.valetHistoryModel.content[index]
                                  .isGuest
                                  ? state.valetHistoryModel.content[index]
                                  .guestName
                                  : state.valetHistoryModel.content[index]
                                  .user!.firstName +
                                  state.valetHistoryModel
                                      .content[index].user!.lastName,
                              status: ScanQrCubit.get(context).status(
                                status: state.valetHistoryModel
                                    .content[index].parkingStatus,
                                isGuest: state.valetHistoryModel
                                    .content[index].isGuest,
                              ),
                              parkingId: state
                                  .valetHistoryModel.content[index].id,
                              isGuest: state.valetHistoryModel
                                  .content[index].isGuest,
                              gate: state.valetHistoryModel
                                  .content[index].retrievingGate,
                            );
                          },
                        )
                            : SizedBox(
                          height: WalletCubit.get(context)
                              .bodyBoxHeight(context, screenHeight),
                          child: const Center(
                              child: Text(
                                Strings.thereAreNoData,
                              )),
                        ),
                      ),
                    )
                  ] else ...[
                    SizedBox(
                      height: WalletCubit.get(context)
                          .bodyBoxHeight(context, screenHeight),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primaryColor,
                        ),
                      ),
                    )
                  ]
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
