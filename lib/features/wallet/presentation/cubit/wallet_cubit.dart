import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  static WalletCubit get(BuildContext context) => BlocProvider.of(context);

  WalletCubit() : super(WalletInitial());

  double bodyBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.7) - 56;

  double headerBoxHeight(BuildContext context, double screenHeight) =>
      screenHeight * 0.3;
}
