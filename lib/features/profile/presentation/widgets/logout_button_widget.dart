import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return SizedBox(
        width: screenWidth * 0.7,
        child: ElevatedButton(
          onPressed: (state is ProfileLoading)
              ? () {}
              : () async {
                  await BottomNavBarCubit.get(context)
                      .updateUserNotificationToken(
                        userId: HomeCubit.get(context).userModel.user.id,
                        tokenId: BottomNavBarCubit.get(context).tokenId,
                        isLogout: true,
                      )
                      .then((_) async => await ProfileCubit.get(context).logout(
                          userId: HomeCubit.get(context).userModel.user.id));
                },
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          child: (state is ProfileLoading)
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: ColorManager.whiteColor,
                  ),
                )
              : const Text(
                  Strings.logout,
                  style: TextStyle(
                      fontFamily: Fonts.sourceSansPro,
                      color: ColorManager.whiteColor,
                      fontWeight: FontWeight.bold),
                ),
        ),
      );
    });
  }
}
