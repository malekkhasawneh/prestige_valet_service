import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/route_manager.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/cubit/add_credit_card_cubit.dart';
import 'package:prestige_valet_app/features/botton_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/payment_gateway/presentation/cubit/payment_gateway_cubit.dart';
import 'package:prestige_valet_app/features/pick_up/presentation/cubit/pick_up_cubit.dart';
import 'package:prestige_valet_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:prestige_valet_app/features/social_auth/presentation/cubit/social_auth_cubit.dart';
import 'package:prestige_valet_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:prestige_valet_app/injection_container/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(
    const PrestigeValetApp(),
  );
}

class PrestigeValetApp extends StatelessWidget {
  const PrestigeValetApp({super.key});

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SocialAuthCubit>(
          create: (_) => di.sl(),
        ),
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorManager.whiteColor,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.splashScreen,
      ),
    );
  }
}
