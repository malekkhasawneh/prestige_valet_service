import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prestige_valet_app/core/resources/images.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  void initState() {
    HomeCubit.get(context).checkInternetConnectionTimer(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                Images.noInternetConnection,
                fit: BoxFit.fill,
                width: 300,
                height: 300,
                frameRate: FrameRate(100),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                Strings.noInternetConnection,
              )
            ],
          ),
        ),
      ),
    );
  }
}
