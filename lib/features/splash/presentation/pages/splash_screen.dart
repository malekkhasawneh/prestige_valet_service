import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/features/splash/presentation/cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashCubit.get(context).getIsFirstTimeOpenTheApp();
    SplashCubit.get(context).checkIfUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit,SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded) {
          if (SplashCubit.get(context).isFirstTime) {
            Future.delayed(const Duration(seconds: 3)).then(
              (_) => Navigator.pushNamed(
                context,
                Routes.welcomeScreen,
              ),
            );
          } else {
            if (state.isLogin) {
              Future.delayed(const Duration(seconds: 3)).then(
                (_) => Navigator.pushNamed(
                  context,
                  Routes.bottomNvBarScreen,
                ),
              );
            } else {
              Future.delayed(const Duration(seconds: 3)).then(
                (_) => Navigator.pushNamed(
                  context,
                  Routes.loginScreen,
                ),
              );
            }
          }
        }
      },
      child: Scaffold(
        body: Center(child: Image.asset(Images.splashLogo)),
      ),
    );
  }
}
