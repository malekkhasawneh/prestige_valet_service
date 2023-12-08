import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/helpers/notification_helper.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/widget/qr_code_widget.dart';
import 'package:prestige_valet_app/features/home/presentation/widget/show_your_history_widget.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeLoading) {
            return const SizedBox();
          } else if (state is HomeLoaded) {
            return Scaffold(
              body: Center(
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
                                0.3,
                          ),
                          child: Text(
                            Strings.mainScreenHiString(
                                userName:
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
                        height:
                        HomeCubit.get(context).bodyBoxHeight(context, screenHeight),
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
                                      0.005,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    Strings.uniqueId,
                                    style: TextStyle(
                                      fontFamily: Fonts.sourceSansPro,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    HomeCubit.get(context).userModel.user.userId.split('-').first,
                                    style: const TextStyle(
                                      fontFamily: Fonts.sourceSansPro,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
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
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
