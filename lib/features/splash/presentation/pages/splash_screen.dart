import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/splash/presentation/cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashCubit.get(context).isFirstOpening();
    SplashCubit.get(context).getIsFirstTimeOpenTheApp();
    SplashCubit.get(context).checkIfUserLogin();
    SplashCubit.get(context).checkIsUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit,SplashState>(
      listener: (context, state) async {
        if (state is SplashLoaded) {
          if (SplashCubit.get(context).isFirstTime ||
              SplashCubit.get(context).isFirstOpining) {
            Future.delayed(const Duration(seconds: 3)).then(
              (_) => Navigator.pushReplacementNamed(
                context,
                Routes.welcomeScreen,
              ),
            );
          } else {
            if (state.isLogin) {
              await HomeCubit.get(context).getUserData(context);
              Future.delayed(const Duration(seconds: 3)).then(
                (_) => Navigator.pushReplacementNamed(
                  context,
                  Routes.bottomNvBarScreen,
                ),
              );
            } else {
              Future.delayed(const Duration(seconds: 3)).then(
                (_) => Navigator.pushReplacementNamed(
                  context,
                  Routes.loginScreen,
                ),
              );
            }
          }
        }else if(state is SplashError){
          if(state.failure == Constants.internetFailure){
            HomeCubit.get(context).refreshAfterConnect = () {
              SplashCubit.get(context).getIsFirstTimeOpenTheApp();
              SplashCubit.get(context).checkIfUserLogin();
              SplashCubit.get(context).checkIsUser();
            };
            Navigator.pushNamed(context, Routes.noInternetScreen);
          }
        }
      },
      child: Scaffold(
        body: Center(child: Image.asset(Images.splashLogo)),
      ),
    );
  }
}
