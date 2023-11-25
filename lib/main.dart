import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/cubit/add_credit_card_cubit.dart';
import 'package:prestige_valet_app/features/botton_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:prestige_valet_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:prestige_valet_app/features/login/presentation/page/login_screen.dart';
import 'package:prestige_valet_app/features/payment_gateway/presentation/cubit/payment_gateway_cubit.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/cubit/pick_up_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:prestige_valet_app/features/scan_qr_code/cubit/scan_qr_cubit.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC27kQq44Sfx2cLTainOBWdpd0QKa_RDtQ",
      appId: "1:752419261145:android:5809786fcf07576fe24cc8",
      messagingSenderId: "752419261145",
      projectId: "prestige-valet-service",
    ),
  );
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
        BlocProvider<BottomNavBarCubit>(create: (_) => BottomNavBarCubit()),
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
        BlocProvider<WalletCubit>(create: (_) => WalletCubit()),
        BlocProvider<ProfileCubit>(create: (_) => ProfileCubit()),
        BlocProvider<AddCreditCardCubit>(create: (_) => AddCreditCardCubit()),
        BlocProvider<EditProfileCubit>(create: (_) => EditProfileCubit()),
        BlocProvider<PickUpCubit>(create: (_) => PickUpCubit()),
        BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),
        BlocProvider<SignUpCubit>(create: (_) => di.sl<SignUpCubit>()),
        BlocProvider<ForgetPasswordCubit>(create: (_) => ForgetPasswordCubit()),
        BlocProvider<ScanQrCubit>(create: (_) => ScanQrCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorManager.whiteColor,
          fontFamily: Fonts.sourceSansPro,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: const LoginScreen(),
      ),
    );
  }
}
