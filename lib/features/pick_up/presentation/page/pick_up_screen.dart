import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/cubit/pick_up_cubit.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/widgets/card_item_widget.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/widgets/confirm_button_widget.dart';

class PickUpScreen extends StatelessWidget {
  const PickUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<PickUpCubit, PickUpState>(
      builder: (context, state) {
        return Scaffold(
          body:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: PickUpCubit.get(context)
                      .headerBoxHeight(context, screenHeight),
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
                      Strings.pickUpTitle,
                      style: TextStyle(
                          fontFamily: Fonts.sourceSansPro,
                          fontSize: 26,
                          color: ColorManager.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: PickUpCubit.get(context)
                      .bodyBoxHeight(context, screenHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 25.0,
                                    mainAxisSpacing: 25.0,
                                    childAspectRatio: 1.3),
                            itemCount: PickUpCubit.get(context).gates.length,
                            itemBuilder: (context, index) {
                              return CardItemWidget(
                                gate: PickUpCubit.get(context).gates[index],
                              );
                            }),
                      ),
                      const ConfirmButtonWidget()
                    ],
                  ),
                ),
              ],
            ),
        );
      },
    );
  }
}
