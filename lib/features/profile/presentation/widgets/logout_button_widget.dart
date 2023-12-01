import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/cache_constants.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.7,
      child: ElevatedButton(
        onPressed: ()async {
          await ProfileCubit.get(context)
              .logout(userId: HomeCubit.get(context).userModel.user.id);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
        ),
        child: const Text(
          Strings.logout,
          style: TextStyle(
            fontFamily: Fonts.sourceSansPro,
            color: ColorManager.whiteColor,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
