import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';

class RequestCarWidget extends StatelessWidget {
  const RequestCarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          top: HomeCubit.get(context).headerBoxHeight(context, screenHeight) -
              24.5),
      child: Row(
        mainAxisAlignment:
            (HomeCubit.get(context).parkedCarModel.carWash ?? false)
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: screenWidth * 0.45,
            height: 43,
            child: ElevatedButton(
              onPressed: () {
                HomeCubit.get(context).setSetGate = true;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.blackColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(25), // Adjust the radius as needed
                ),
              ),
              child: const Text(
                Strings.requestCar,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          (HomeCubit.get(context).parkedCarModel.carWash ?? false)
              ? const SizedBox.shrink()
              : SizedBox(
                  width: screenWidth * 0.45,
                  height: 43,
                  child: ElevatedButton(
                    onPressed: () {
                      HomeCubit.get(context).washCar(
                          parkingId: HomeCubit.get(context).parkedCarModel.id,
                          washFlag: true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.blackColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            25), // Adjust the radius as needed
                      ),
                    ),
                    child: const Text(
                      Strings.washCar,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorManager.whiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
