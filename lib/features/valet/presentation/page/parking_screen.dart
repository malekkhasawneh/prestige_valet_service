import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
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
    return BlocBuilder<ScanQrCubit, ScanQrState>(builder: (context, state) {
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
                                    user: state
                                        .valetHistoryModel.content[index].user,
                                    status: ScanQrCubit.get(context).status(
                                        status: state.valetHistoryModel
                                            .content[index].parkingStatus),
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
