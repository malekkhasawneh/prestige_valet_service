import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/cubit/pick_up_cubit.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart'
    as cubit;
import 'package:prestige_valet_app/features/valet/presentation/widgets/gate_type_card_widget.dart';
import 'package:prestige_valet_app/features/valet/presentation/widgets/park_car_button_widget.dart';

class SelectGateTypeScreen extends StatefulWidget {
  const SelectGateTypeScreen({super.key});

  @override
  State<SelectGateTypeScreen> createState() => _SelectGateTypeScreenState();
}

class _SelectGateTypeScreenState extends State<SelectGateTypeScreen> {
  @override
  void initState() {
    cubit.ScanQrCubit.get(context).selectedParkingId = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<cubit.ScanQrCubit, cubit.ScanQrState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context,false);
            },
            child: const Icon(
              Icons.arrow_back,
              color: ColorManager.whiteColor,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: PickUpCubit.get(context)
                          .headerBoxHeight(context, screenHeight) -
                      2,
                  width: screenWidth,
                  color: ColorManager.primaryColor,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      top: PickUpCubit.get(context)
                              .headerBoxHeight(context, screenHeight) *
                          0.35,
                    ),
                    child: Text(
                      Strings.selectParingTypeHeader,
                      style: const TextStyle(
                          fontFamily: Fonts.sourceSansPro,
                          fontSize: 26,
                          color: ColorManager.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (state is cubit.SetValueLoading) ...[
                  const Expanded(
                    flex: 1,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primaryColor,
                      ),
                    ),
                  )
                ] else ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    height: PickUpCubit.get(context)
                        .bodyBoxHeight(context, screenHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: cubit.ScanQrCubit.get(context)
                                  .valetParkingTypesList
                                  .isNotEmpty
                              ? GridView.builder(
                                  padding: const EdgeInsets.only(top: 20),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 25.0,
                                          mainAxisSpacing: 25.0,
                                          childAspectRatio: 1.3),
                                  itemCount: cubit.ScanQrCubit.get(context)
                                      .valetParkingTypesList
                                      .length,
                                  itemBuilder: (context, index) {
                                    return GateTypeCardWidget(
                                      name: cubit.ScanQrCubit.get(context)
                                          .valetParkingTypesList[index]
                                          .type,
                                      onTap: () {
                                        cubit.ScanQrCubit.get(context)
                                            .valetParkingTypesList
                                            .forEach((element) {
                                          element.isSelected = false;
                                        });
                                        cubit.ScanQrCubit.get(context)
                                            .valetParkingTypesList[index]
                                            .isSelected = true;
                                        cubit.ScanQrCubit.get(context)
                                                .selectedParkingId =
                                            cubit.ScanQrCubit.get(context)
                                                .valetParkingTypesList[index]
                                                .id;
                                        setState(() {});
                                      },
                                      isSelected: cubit.ScanQrCubit.get(context)
                                          .valetParkingTypesList[index]
                                          .isSelected,
                                    );
                                  })
                              : const Center(
                                  child: Text(Strings.thereAreNoData),
                                ),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
            const Positioned(
              bottom: 20,
              child: ParkCarButtonWidget(),
            ),
          ],
        ),
      );
    });
  }
}
