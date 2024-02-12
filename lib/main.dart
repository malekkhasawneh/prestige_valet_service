import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prestige_valet_app/core/helpers/firebase_messaging_helper.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/cubit/add_credit_card_cubit.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:prestige_valet_app/features/payment_gateway/presentation/cubit/payment_gateway_cubit.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/cubit/pick_up_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:prestige_valet_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:prestige_valet_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:prestige_valet_app/features/valet/presentation/cubit/scan_qr_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Constants.envFileName);
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env[Constants.androidFirebaseApiKey]!,
      appId: dotenv.env[Constants.androidAppId]!,
      messagingSenderId: dotenv.env[Constants.androidMessagingSenderId]!,
      projectId: dotenv.env[Constants.androidProjectId]!,
    ),
  );
  await FirebaseMessagingHelper.initNotifications();
  await di.init();
  runApp(
    const PrestigeValetApp(),
  );
}

class PrestigeValetApp extends StatelessWidget {
  const PrestigeValetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaymentGatewayCubit>(
          create: (_) => di.sl(),
        ),
        BlocProvider<BottomNavBarCubit>(
            create: (_) => di.sl<BottomNavBarCubit>()),
        BlocProvider<HomeCubit>(create: (_) => di.sl<HomeCubit>()),
        BlocProvider<WalletCubit>(create: (_) => di.sl<WalletCubit>()),
        BlocProvider<ProfileCubit>(create: (_) => di.sl<ProfileCubit>()),
        BlocProvider<AddCreditCardCubit>(
            create: (_) => di.sl<AddCreditCardCubit>()),
        BlocProvider<EditProfileCubit>(
            create: (_) => di.sl<EditProfileCubit>()),
        BlocProvider<PickUpCubit>(create: (_) => di.sl<PickUpCubit>()),
        BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
        BlocProvider<SignUpCubit>(create: (_) => di.sl<SignUpCubit>()),
        BlocProvider<ForgetPasswordCubit>(
            create: (_) => di.sl<ForgetPasswordCubit>()),
        BlocProvider<ScanQrCubit>(create: (_) => di.sl<ScanQrCubit>()),
        BlocProvider<SplashCubit>(create: (_) => di.sl<SplashCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorManager.whiteColor,
          fontFamily: Fonts.sourceSansPro,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
// Copyright 2017-2023, Charles Weinberger & Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
//
// import 'screens/bluetooth_off_screen.dart';
// import 'screens/scan_screen.dart';
//
// void main() {
//   FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
//   runApp(const FlutterBlueApp());
// }
//
// //
// // This widget shows BluetoothOffScreen or
// // ScanScreen depending on the adapter state
// //
// class FlutterBlueApp extends StatefulWidget {
//   const FlutterBlueApp({Key? key}) : super(key: key);
//
//   @override
//   State<FlutterBlueApp> createState() => _FlutterBlueAppState();
// }
//
// class _FlutterBlueAppState extends State<FlutterBlueApp> {
//   BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
//
//   late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
//       _adapterState = state;
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _adapterStateStateSubscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget screen = _adapterState == BluetoothAdapterState.on
//         ? const ScanScreen()
//         : BluetoothOffScreen(adapterState: _adapterState);
//
//     return MaterialApp(
//       color: Colors.lightBlue,
//       home: screen,
//       navigatorObservers: [BluetoothAdapterStateObserver()],
//     );
//   }
// }
//
// //
// // This observer listens for Bluetooth Off and dismisses the DeviceScreen
// //
// class BluetoothAdapterStateObserver extends NavigatorObserver {
//   StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
//
//   @override
//   void didPush(Route route, Route? previousRoute) {
//     super.didPush(route, previousRoute);
//     if (route.settings.name == '/DeviceScreen') {
//       // Start listening to Bluetooth state changes when a new route is pushed
//       _adapterStateSubscription ??= FlutterBluePlus.adapterState.listen((state) {
//         if (state != BluetoothAdapterState.on) {
//           // Pop the current route if Bluetooth is off
//           navigator?.pop();
//         }
//       });
//     }
//   }
//
//   @override
//   void didPop(Route route, Route? previousRoute) {
//     super.didPop(route, previousRoute);
//     // Cancel the subscription when the route is popped
//     _adapterStateSubscription?.cancel();
//     _adapterStateSubscription = null;
//   }
// }
