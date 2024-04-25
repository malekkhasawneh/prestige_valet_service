import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/widgets/logout_button_widget.dart';
import 'package:prestige_valet_app/features/profile/presentation/widgets/profile_items_widget.dart';
import 'package:prestige_valet_app/features/profile/presentation/widgets/user_info_widget.dart';
import 'package:prestige_valet_app/features/valet_history/page/valet_history_screen.dart';

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
      }else if(state is ProfileError){
        if(state.failure == Constants.internetFailure){
          Navigator.pushNamed(context, Routes.noInternetScreen);
        }
      }
    }, builder: (context, state) {
return BlocBuilder<HomeCubit,HomeState>(builder: (context,state){
  return HomeCubit.get(context).getIsHistoryPage?const ValetHistoryScreen(): Scaffold(
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
      leading: const SizedBox(
        width: 30,
      ),
    ),
    body: SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
            ),
            children: const <Widget>[
              UserInfoWidget(),
              ProfileItemsWidget(),
              //DisCountCardWidget(),
            ],
          ),
          const Positioned(bottom: 10, child: LogoutButtonWidget()),
        ],
      ),
    ),
  );

},);
    });
  }
}
