import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBarCubit, BottomNavBarState>(
        listener: (context, state) {},
        builder: (context, state) {
          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Center(
                child: BottomNavBarCubit.get(context).widgetOptions(
                    context)[BottomNavBarCubit.get(context).getSelectedIndex],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: Strings.home,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.wallet),
                    label: Strings.wallet,
                  ),
                  BottomNavigationBarItem(
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
