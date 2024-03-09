import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:prestige_valet_app/core/helpers/database_helper.dart';
import 'package:prestige_valet_app/core/helpers/notification_helper.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/injection_container/add_card_injection.dart';
import 'package:prestige_valet_app/injection_container/bottom_nav_injection.dart';
import 'package:prestige_valet_app/injection_container/edit_profile_injection.dart';
import 'package:prestige_valet_app/injection_container/forget_password_injection.dart';
import 'package:prestige_valet_app/injection_container/home_injection.dart';
import 'package:prestige_valet_app/injection_container/login_injection.dart';
import 'package:prestige_valet_app/injection_container/pick_up_injection.dart';
import 'package:prestige_valet_app/injection_container/sign_up_injection.dart';
import 'package:prestige_valet_app/injection_container/splash_injection.dart';
import 'package:prestige_valet_app/injection_container/valet_injection.dart';
import 'package:prestige_valet_app/injection_container/wallet_injection.dart';

import 'profile_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Injections
  //paymentGatewayInjection();
  signUpInjection();
  loginInjection();
  homeInjection();
  forgetPasswordInjection();
  walletInjection();
  editProfileInjection();
  addCardInjection();
  splashInjection();
  pickUpInjection();
  profileInjection();
  valetInjection();
  bottomNavInjection();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        connectivity: sl(),
        internetConnectionChecker: sl(),
      ));
  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DatabaseHelper());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  await NotificationHelper.init();
  if (Platform.isIOS) {
    DartPingIOS.register();
  }
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env[Constants.androidFirebaseApiKey]!,
        appId: dotenv.env[Constants.androidAppId]!,
        messagingSenderId: dotenv.env[Constants.androidMessagingSenderId]!,
        projectId: dotenv.env[Constants.androidProjectId]!,
      ),
    );
  } catch (error) {
    await Firebase.initializeApp();
  }
}
