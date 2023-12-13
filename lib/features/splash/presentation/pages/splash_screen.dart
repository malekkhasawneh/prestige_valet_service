import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/features/payment_gateway/presentation/page/my_fatoorah_screen.dart';
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
    SplashCubit.get(context).checkIsUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit,SplashState>(
      listener: (context, state) async {
        if (state is SplashLoaded) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const MyFatoorahScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(child: Image.asset(Images.splashLogo)),
      ),
    );
  }
}
