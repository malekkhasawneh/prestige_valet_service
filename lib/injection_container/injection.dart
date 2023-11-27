import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/injection_container/forget_password_injection.dart';
import 'package:prestige_valet_app/injection_container/home_injection.dart';
import 'package:prestige_valet_app/injection_container/login_injection.dart';
import 'package:prestige_valet_app/injection_container/payment_gateway_injection.dart';
import 'package:prestige_valet_app/injection_container/sign_up_injection.dart';
import 'package:prestige_valet_app/injection_container/wallet_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Injections
  paymentGatewayInjection();
  signUpInjection();
  loginInjection();
  homeInjection();
  forgetPasswordInjection();
  walletInjection();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        connectivity: sl(),
        internetConnectionChecker: sl(),
      ));
  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
