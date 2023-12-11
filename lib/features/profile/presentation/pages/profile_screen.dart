import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/widgets/discount_card_widget.dart';
import 'package:prestige_valet_app/features/profile/presentation/widgets/logout_button_widget.dart';
import 'package:prestige_valet_app/features/profile/presentation/widgets/profile_items_widget.dart';
import 'package:prestige_valet_app/features/profile/presentation/widgets/user_info_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
      if (state is ProfileLoaded) {
        if (state.logout) {
          Navigator.pushReplacementNamed(context, Routes.loginScreen);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.transparent,
          elevation: 0,
          title: const Text(
            Strings.profile,
            style: TextStyle(
              fontFamily: Fonts.sourceSansPro,
              fontSize: 26,
              color: ColorManager.blackColor,
            ),
          ),
          leading: const Icon(
            Icons.arrow_back,
            color: ColorManager.blackColor,
            size: 30,
          ),
        ),
        body: SizedBox(
          height: screenHeight,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
            ),
            children: const <Widget>[
              UserInfoWidget(),
              ProfileItemsWidget(),
              DisCountCardWidget(),
              LogoutButtonWidget(),
            ],
          ),
        ),
      );
    });
  }
}
