import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/add_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/get_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/must_reset_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/usecase/update_notification_token_usecase.dart';
import 'package:prestige_valet_app/features/home/presentation/page/main_home_screen.dart';
import 'package:prestige_valet_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:prestige_valet_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:prestige_valet_app/features/valet/presentation/page/parking_screen.dart';
import 'package:prestige_valet_app/features/valet/presentation/page/scan_qr_code_screen.dart';
import 'package:prestige_valet_app/features/wallet/presentation/page/wallet_screen.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  static BottomNavBarCubit get(BuildContext context) =>
      BlocProvider.of(context);

  BottomNavBarCubit({
    required this.getNotificationTokenUseCase,
    required this.updateNotificationTokenUseCase,
    required this.addNotificationTokenUseCase,
    required this.mustResetNotificationTokenUseCase,
  }) : super(BottomNavBarInitial());

  final AddNotificationTokenUseCase addNotificationTokenUseCase;
  final UpdateNotificationTokenUseCase updateNotificationTokenUseCase;
  final GetNotificationTokenUseCase getNotificationTokenUseCase;
  final MustResetNotificationTokenUseCase mustResetNotificationTokenUseCase;
  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;

  set setIndex(int value) {
    emit(SetAndGetValueLoading());
    _selectedIndex = value;
    emit(SetAndGetValueLoaded());
  }

  String userNotificationToken = '';
  int tokenId = -1;
  bool canUpdateToken = true;

  List<Widget> widgetOptions(BuildContext context) =>
      <Widget>[
        SplashCubit.get(context).isUser
            ? const MainHomeScreen()
            : const ScanQrCodeScreen(),
        SplashCubit.get(context).isUser
            ? const WalletScreen()
            : const ParkingScreen(),
        const ProfileScreen(),
      ];

  Future<void> addNotificationToken({required int userId}) async {
    emit(BottomNavBarLoading());
    try {
      final response = await addNotificationTokenUseCase(
          AddNotificationTokenUseCaseParams(
              userId: userId, token: await getTokenForUser()));
      response
          .fold((failure) => emit(BottomNavBarError(failure: failure.failure)),
              (success) {
            userNotificationToken = success.notificationToken;
        tokenId = success.id;
        log('====================================== in add id ${success.id}');
        log('====================================== in add token ${success.notificationToken}');
        emit(BottomNavBarLoaded());
      });
    } catch (failure) {
      emit(BottomNavBarError(failure: failure.toString()));
    }
  }

  Future<void> getNotificationTokenForUser({required int userId}) async {
    emit(BottomNavBarLoading());
    try {
      final response =
      await getNotificationTokenUseCase(GetNotificationTokenUseCaseParams(
        userId: userId,
      ));
      response.fold((failure) {
        emit(GetUserTokenError(failure: failure.failure));
      }, (success) async {
        userNotificationToken = success.content.notificationToken;
        tokenId = success.content.id;
        log('====================================== in get id ${success.content.id}');
        log('====================================== in get token ${success.content.notificationToken}');
        if (await mustResetNotificationToken()) {
          addNotificationToken(userId: userId);
        }
        emit(BottomNavBarLoaded());
      });
    } catch (failure) {
      emit(GetUserTokenError(
          failure: failure.toString().split(':').last.trim()));
    }
  }

  Future<void> updateUserNotificationToken({
    required int userId,
    required int tokenId,
    bool isLogout = false,
  }) async {
    emit(BottomNavBarLoading());
    try {
      final response = await updateNotificationTokenUseCase(
          UpdateNotificationTokenUseCaseParams(
            userId: userId,
            tokenId: tokenId,
            token: isLogout ? Constants.userLoggedOut : await getTokenForUser(),
          ));
      response
          .fold((failure) => emit(BottomNavBarError(failure: failure.failure)),
              (success) {
            userNotificationToken = success.notificationToken;
        tokenId = success.id;
        log('====================================== in update id ${success.id}');
        log('====================================== in update token ${success.notificationToken}');
        emit(BottomNavBarLoaded());
      });
    } catch (failure) {
      emit(BottomNavBarError(failure: failure.toString()));
    }
  }

  Future<bool> mustResetNotificationToken() async {
    bool isTrue = false;
    emit(BottomNavBarLoading());
    try {
      final response = await mustResetNotificationTokenUseCase(NoParams());
      response.fold((failure) {
        isTrue = false;
      }, (success) {
        isTrue = success;
      });
    } catch (failure) {
      isTrue = false;
    }
    return isTrue;
  }

  Future<String> getTokenForUser() async {
    return await FirebaseMessaging.instance.getToken() ?? '';
  }
}
