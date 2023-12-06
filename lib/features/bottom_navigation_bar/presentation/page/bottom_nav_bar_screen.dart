import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/splash/presentation/cubit/splash_cubit.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBarCubit, BottomNavBarState>(
        listener: (context, state) {
      if (state is GetUserTokenError) {
        if (state.failure == Constants.noElement) {
          BottomNavBarCubit.get(context).addNotificationToken(
              userId: HomeCubit.get(context).userModel.user.id);
        }
      } else if (state is BottomNavBarLoaded) {
        if (BottomNavBarCubit.get(context).userNotificationToken ==
                Constants.userLoggedOut &&
            BottomNavBarCubit.get(context).canUpdateToken) {
          BottomNavBarCubit.get(context).updateUserNotificationToken(
              userId: HomeCubit.get(context).userModel.user.id,
              tokenId: BottomNavBarCubit.get(context).tokenId);
        }
      }
    }, builder: (context, state) {
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Center(
            child: BottomNavBarCubit.get(context).widgetOptions(
                context)[BottomNavBarCubit.get(context).getSelectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: Strings.home,
              ),
              BottomNavigationBarItem(
                icon: SplashCubit.get(context).isUser
                    ? const Icon(Icons.wallet)
                    : const Icon(Icons.local_parking),
                label: SplashCubit.get(context).isUser
                    ? Strings.wallet
                    : Strings.parking,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: Strings.profile,
              ),
            ],
            currentIndex: BottomNavBarCubit.get(context).getSelectedIndex,
            selectedItemColor: ColorManager.primaryColor,
            unselectedItemColor: ColorManager.blackColor,
            onTap: (int index) {
              BottomNavBarCubit.get(context).setIndex = index;
              setState(() {});
            },
          ),
        ),
      );
    });
  }
}
