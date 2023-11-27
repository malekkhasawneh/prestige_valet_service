import 'package:flutter/material.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/page/add_credit_card_screen.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/page/bottom_nav_bar_screen.dart';
import 'package:prestige_valet_app/features/edit_profile/presentation/page/edit_profile_screen.dart';
import 'package:prestige_valet_app/features/home/presentation/page/car_parked_home_screen.dart';
import 'package:prestige_valet_app/features/home/presentation/page/main_home_screen.dart';
import 'package:prestige_valet_app/features/login/presentation/page/login_screen.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/page/pick_up_screen.dart';
import 'package:prestige_valet_app/features/proccess_screens/car_ready_screen.dart';
import 'package:prestige_valet_app/features/proccess_screens/parcked_sucessfully_screen.dart';
import 'package:prestige_valet_app/features/proccess_screens/success_screen.dart';
import 'package:prestige_valet_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:prestige_valet_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:prestige_valet_app/features/splash/presentation/pages/welcome_screen.dart';
import 'package:prestige_valet_app/features/valet_history/page/valet_history_screen.dart';

class Routes {
  static const String splashScreen = "/";
  static const String welcomeScreen = "/welcomeScreen";
  static const String loginScreen = "/loginScreen";
  static const String carParkedHomeScreen = "/carParkedHomeScreen";
  static const String mainHomeScreen = "/mainHomeScreen";
  static const String bottomNvBarScreen = "/bottomNavBarScreen";
  static const String parkedSuccessfullyScreen = "/parkedSuccessfullyScreen";
  static const String carReadyScreen = "/carReadyScreen";
  static const String profileScreen = "/profileScreen";
  static const String successScreen = "/successScreen";
  static const String addCreditCardScreen = "/addCreditCardScreen";
  static const String valetHistoryScreen = "/valetHistoryScreen";
  static const String editProfileScreen = "/editProfileScreen";
  static const String pickUpScreen = "/pickUpScreen";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.welcomeScreen:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.carParkedHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const CarParkedHomeScreen(),
        );
      case Routes.mainHomeScreen:
        return MaterialPageRoute(
          builder: (_) => const MainHomeScreen(),
        );
      case Routes.bottomNvBarScreen:
        return MaterialPageRoute(
          builder: (_) => const BottomNavBarScreen(),
        );
      case Routes.parkedSuccessfullyScreen:
        return MaterialPageRoute(
          builder: (_) => const ParkedSuccessfullyScreen(),
        );
      case Routes.carReadyScreen:
        return MaterialPageRoute(
          builder: (_) => const CarReadyScreen(),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case Routes.successScreen:
        return MaterialPageRoute(
          builder: (_) => const SuccessScreen(),
        );
      case Routes.addCreditCardScreen:
        return MaterialPageRoute(
          builder: (_) => const AddCreditCardScreen(),
        );
      case Routes.valetHistoryScreen:
        return MaterialPageRoute(
          builder: (_) => const ValetHistoryScreen(),
        );
      case Routes.editProfileScreen:
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        );
      case Routes.pickUpScreen:
        return MaterialPageRoute(
          builder: (_) => const PickUpScreen(),
        );
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
