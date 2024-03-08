import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/widget/qr_code_widget.dart';
import 'package:prestige_valet_app/features/home/presentation/widget/show_your_history_widget.dart';
import 'package:prestige_valet_app/features/proccess_screens/car_ready_screen.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is HomeError){
            if(state.failure == Constants.internetFailure){
              Navigator.pushNamed(context, Routes.noInternetScreen);
            }
          }
        },
        builder: (context, state) {
          return const CarReadyScreen();
        });
  }
}
