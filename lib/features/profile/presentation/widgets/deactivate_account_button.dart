import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class DeactivateAccountButton extends StatelessWidget {
  const DeactivateAccountButton({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return SizedBox(
        width: screenWidth * 0.9,
        height: 45,
        child: ElevatedButton(
          onPressed:
              (state is ProfileLoading || state is DeactivateAccountLoading)
                  ? () {}
                  : () {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.topSlide,
                        dialogType: DialogType.warning,
                        dismissOnTouchOutside: false,
                        dismissOnBackKeyPress: false,
                        body: const Center(
                          child: Text(
                            Strings.deleteAccountMsg,
                            style: TextStyle(
                              color: ColorManager.blackColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        btnOkOnPress: () async {
                          BottomNavBarCubit.get(context).isLogout = true;
                          BottomNavBarCubit.get(context).addNotificationToken(
                              userId: HomeCubit.get(context).userModel.user.id,
                              isLogout: true);
                          await ProfileCubit.get(context).deleteUserAccount();
                        },
                        btnCancelOnPress: () {},
                        btnCancelColor: Colors.red,
                        btnOkColor: Colors.green,
                      ).show();
                    },
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.blackColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          child: (state is DeactivateAccountLoading)
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: ColorManager.whiteColor,
                  ),
                )
              : const Text(
                  Strings.deleteAccount,
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
