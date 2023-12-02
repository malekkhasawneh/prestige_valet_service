import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/widget/qr_code_widget.dart';
import 'package:prestige_valet_app/features/home/presentation/widget/request_car_widget.dart';
import 'package:prestige_valet_app/features/home/presentation/widget/show_your_history_widget.dart';

class CarParkedHomeScreen extends StatefulWidget {
  const CarParkedHomeScreen({super.key});

  @override
  State<CarParkedHomeScreen> createState() => _CarParkedHomeScreenState();
}

class _CarParkedHomeScreenState extends State<CarParkedHomeScreen> {
  @override
  void initState() {
    HomeCubit.get(context).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
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
                      Strings.carParkedHiString(
                          HomeCubit.get(context).userModel.user.firstName),
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
                            height: HomeCubit.get(context)
                                    .bodyBoxHeight(context, screenHeight) *
                                0.2,
                          ),
                          QrCodeWidget(
                            screenHeight: screenHeight,
                          ),
                          SizedBox(
                            height: HomeCubit.get(context)
                                    .bodyBoxHeight(context, screenHeight) *
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
                          const Text(
                            'x23-657',
                            style: TextStyle(
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
