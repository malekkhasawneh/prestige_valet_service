import 'package:flutter/material.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/page/add_credit_card_screen.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/page/bottom_nav_bar_screen.dart';
import 'package:prestige_valet_app/features/edit_profile/presentation/page/edit_profile_screen.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/page/forget_password_screen.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/page/update_your_password.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/page/verify_reset_password_email_screen.dart';
import 'package:prestige_valet_app/features/home/presentation/page/car_parked_home_screen.dart';
import 'package:prestige_valet_app/features/home/presentation/page/main_home_screen.dart';
import 'package:prestige_valet_app/features/login/presentation/page/login_screen.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/page/pick_up_screen.dart';
import 'package:prestige_valet_app/features/proccess_screens/car_ready_screen.dart';
import 'package:prestige_valet_app/features/proccess_screens/no_internet_screen.dart';
import 'package:prestige_valet_app/features/proccess_screens/parcked_sucessfully_screen.dart';
import 'package:prestige_valet_app/features/proccess_screens/success_screen.dart';
import 'package:prestige_valet_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/page/sign_up_screen.dart';
import 'package:prestige_valet_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:prestige_valet_app/features/splash/presentation/pages/welcome_screen.dart';
import 'package:prestige_valet_app/features/valet_history/page/valet_history_screen.dart';
import 'package:prestige_valet_app/features/wallet/presentation/page/wallet_screen.dart';

class Routes {
  static const String splashScreen = "/";
  static const String welcomeScreen = "/welcomeScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String loginScreen = "/loginScreen";
  static const String carParkedHomeScreen = "/carParkedHomeScreen";
  static const String mainHomeScreen = "/mainHomeScreen";
  static const String bottomNvBarScreen = "/bottomNavBarScreen";
  static const String parkedSuccessfullyScreen = "/parkedSuccessfullyScreen";
  static const String carReadyScreen = "/carReadyScreen";
  static const String walletScreen = "/walletScreen";
  static const String profileScreen = "/profileScreen";
  static const String successScreen = "/successScreen";
  static const String addCreditCardScreen = "/addCreditCardScreen";
  static const String valetHistoryScreen = "/valetHistoryScreen";
  static const String editProfileScreen = "/editProfileScreen";
  static const String pickUpScreen = "/pickUpScreen";
  static const String forgetPasswordScreen = "/forgetPasswordScreen";
  static const String verifyResetPasswordEmailScreen =
      '/verifyResetPasswordEmailScreen';
  static const String updateYourPasswordScreen = '/updateYourPasswordScreen';
  static const String noInternetScreen = '/noInternetScreen';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
            settings: const RouteSettings(name: Routes.splashScreen));
      case Routes.welcomeScreen:
        return MaterialPageRoute(
            builder: (_) => const WelcomeScreen(),
            settings: const RouteSettings(name: Routes.welcomeScreen));
      case Routes.signUpScreen:
        return MaterialPageRoute(
            builder: (_) => const SignUpScreen(),
            settings: const RouteSettings(name: Routes.signUpScreen));
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => const LoginScreen(),
            settings: const RouteSettings(name: Routes.loginScreen));
      case Routes.walletScreen:
        return MaterialPageRoute(
            builder: (_) => const WalletScreen(),
            settings: const RouteSettings(name: Routes.walletScreen));
      case Routes.carParkedHomeScreen:
        return MaterialPageRoute(
            builder: (_) => const CarParkedHomeScreen(),
            settings: const RouteSettings(name: Routes.carParkedHomeScreen));
      case Routes.mainHomeScreen:
        return MaterialPageRoute(
            builder: (_) => const MainHomeScreen(),
            settings: const RouteSettings(name: Routes.mainHomeScreen));
      case Routes.bottomNvBarScreen:
        return MaterialPageRoute(
            builder: (_) => const BottomNavBarScreen(),
            settings: const RouteSettings(name: Routes.bottomNvBarScreen));
      case Routes.parkedSuccessfullyScreen:
        return MaterialPageRoute(
            builder: (_) => const ParkedSuccessfullyScreen(),
            settings:
                const RouteSettings(name: Routes.parkedSuccessfullyScreen));
      case Routes.carReadyScreen:
        return MaterialPageRoute(
            builder: (_) => const CarReadyScreen(),
            settings: const RouteSettings(name: Routes.carReadyScreen));
      case Routes.profileScreen:
        return MaterialPageRoute(
            builder: (_) => const ProfileScreen(),
            settings: const RouteSettings(name: Routes.profileScreen));
      case Routes.successScreen:
        return MaterialPageRoute(
            builder: (_) => const SuccessScreen(),
            settings: const RouteSettings(name: Routes.successScreen));
      case Routes.addCreditCardScreen:
        return MaterialPageRoute(
            builder: (_) => const AddCreditCardScreen(),
            settings: const RouteSettings(name: Routes.addCreditCardScreen));
      case Routes.valetHistoryScreen:
        return MaterialPageRoute(
            builder: (_) => const ValetHistoryScreen(),
            settings: const RouteSettings(name: Routes.valetHistoryScreen));
      case Routes.editProfileScreen:
        return MaterialPageRoute(
            builder: (_) => const EditProfileScreen(),
            settings: const RouteSettings(name: Routes.editProfileScreen));
      case Routes.pickUpScreen:
        return MaterialPageRoute(
            builder: (_) => const PickUpScreen(),
            settings: const RouteSettings(name: Routes.pickUpScreen));
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
            builder: (_) => const ForgetPasswordScreen(),
            settings: const RouteSettings(name: Routes.forgetPasswordScreen));
      case Routes.verifyResetPasswordEmailScreen:
        return MaterialPageRoute(
            builder: (_) => const VerifyResetPasswordEmailScreen(),
            settings: const RouteSettings(
                name: Routes.verifyResetPasswordEmailScreen));
      case Routes.updateYourPasswordScreen:
        return MaterialPageRoute(
            builder: (_) => const UpdateYourPasswordScreen(),
            settings:
                const RouteSettings(name: Routes.updateYourPasswordScreen));
      case Routes.noInternetScreen:
        return MaterialPageRoute(
            builder: (_) => const NoInternetScreen(),
            settings:
            const RouteSettings(name: Routes.noInternetScreen));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('page not found'),
        ),
      ),
    );
  }
}
