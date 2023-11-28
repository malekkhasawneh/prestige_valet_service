import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/cubit/pick_up_cubit.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/widgets/card_item_widget.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/widgets/confirm_button_widget.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  @override
  void initState() {
    PickUpCubit.get(context).getGates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<PickUpCubit, PickUpState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Column(
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
                        if (state is PickUpLoaded) ...[
                          Expanded(
                            flex: 1,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 25.0,
                                        mainAxisSpacing: 25.0,
                                        childAspectRatio: 1.3),
                                itemCount: state.gatesModel.gates.length,
                                itemBuilder: (context, index) {
                                  return CardItemWidget(
                                    onTap: () {
                                      for (var gate in state.gatesModel.gates) {
                                        gate.isSelected = false;
                                      }
                                      state.gatesModel.gates[index].isSelected =
                                          !state.gatesModel.gates[index]
                                              .isSelected;
                                      setState(() {});
                                    },
                                    gate: state.gatesModel.gates[index],
                                  );
                                }),
                          ),
                        ] else ...[
                          const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.primaryColor,
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const Positioned(
                bottom: 20,
                child: ConfirmButtonWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}
