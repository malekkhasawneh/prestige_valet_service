import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/features/home/presentation/page/car_parked_home_screen.dart';
import 'package:prestige_valet_app/features/home/presentation/page/main_home_screen.dart';
import 'package:prestige_valet_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:prestige_valet_app/features/wallet/presentation/page/wallet_screen.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  static BottomNavBarCubit get(BuildContext context) =>
      BlocProvider.of(context);

  BottomNavBarCubit() : super(BottomNavBarInitial());

  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;

  set setIndex(int value) {
    emit(BottomNavBarLoading());
    _selectedIndex = value;
    emit(BottomNavBarLoading());
  }

  List<Widget> widgetOptions = <Widget>[
    const MainHomeScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];
}
