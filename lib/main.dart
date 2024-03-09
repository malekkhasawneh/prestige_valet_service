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
  await di.init();
  await FirebaseMessagingHelper.initNotifications();
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

