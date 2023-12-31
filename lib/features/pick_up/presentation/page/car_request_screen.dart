import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/cubit/pick_up_cubit.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/widgets/cancel_button_widget.dart';

class CarRequestScreen extends StatelessWidget {
  const CarRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height:
                    PickUpCubit.get(context).headerBoxHeight(context, screenHeight),
                width: screenWidth,
                color: ColorManager.primaryColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.05,
                    top: PickUpCubit.get(context)
                            .headerBoxHeight(context, screenHeight) *
                        0.35,
                  ),
                  child: const Text(
                    Strings.carRequestTitle,
                    style: TextStyle(
                        fontFamily: Fonts.sourceSansPro,
                        fontSize: 26,
                        color: ColorManager.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height:
                    PickUpCubit.get(context).bodyBoxHeight(context, screenHeight),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.car_rental,
                      color: ColorManager.blackColor,
                      size: 110,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      Strings.carRequestNotification,
                      style:
                          TextStyle(fontFamily: Fonts.sourceSansPro, fontSize: 15),
                    ),
                  ],
                ),
              )
            ],
          ),
          const CancelButtonWidget(),
        ],
      ),
    );
  }
}
