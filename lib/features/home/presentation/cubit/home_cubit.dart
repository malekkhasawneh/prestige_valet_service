import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/helpers/notification_helper.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/get_user_data_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/get_user_history_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/retrieve_car_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/send_notification_usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/wash_car_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  HomeCubit({
    required this.getUserDataUseCase,
    required this.retrieveCarUseCase,
    required this.washCarUseCase,
    required this.getUserHistoryUseCase,
  }) : super(HomeInitial());

  final GetUserDataUseCase getUserDataUseCase;
  final RetrieveCarUseCase retrieveCarUseCase;
  final WashCarUseCase washCarUseCase;
  final GetUserHistoryUseCase getUserHistoryUseCase;

  double bodyBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.7) - 56;

  double headerBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.3) - 2;

  late SignUpModel userModel;

  Future<void> getUserData(BuildContext context) async {
    emit(HomeLoading());
    try {
      final response = await getUserDataUseCase(NoParams());
      response.fold((failure) => emit(HomeError(failure: failure.toString())),
          (userModel) {
        this.userModel = userModel;
        log('======================================= token ${userModel.token}');
        BottomNavBarCubit.get(context)
            .getNotificationTokenForUser(userId: userModel.user.id);
        emit(HomeLoaded());
      });
    } catch (failure) {
      emit(HomeError(failure: failure.toString()));
    }
  }

  Future<void> retrieveCar(
      {required int parkingId, required int gateId}) async {
    emit(HomeLoading());
    try {
      final response = await retrieveCarUseCase(
          RetrieveCarUseCaseParams(parkingId: parkingId, gateId: gateId));
      response.fold((failure) => emit(HomeError(failure: failure.toString())),
          (success) {
        emit(RetrieveCarLoaded(parkedCarsModel: success));
      });
    } catch (failure) {
      emit(HomeError(failure: failure.toString()));
    }
  }

  Future<void> washCar({required int parkingId, required bool washFlag}) async {
    emit(HomeLoading());
    try {
      final response = await washCarUseCase(
          WashCarUseCaseParams(parkingId: parkingId, washFlag: washFlag));
      response.fold((failure) => emit(HomeError(failure: failure.toString())),
          (success) {
        emit(WashCarLoaded(parkedCarsModel: success));
      });
    } catch (failure) {
      emit(HomeError(failure: failure.toString()));
    }
  }

  Future<void> getUserHistory({
    required int userId,
  }) async {
    emit(HomeLoading());
    try {
      final response = await getUserHistoryUseCase(
          GetUserHistoryUseCaseParams(userId: userId));
      response.fold((failure) {
        emit(HomeError(failure: failure.toString()));
      }, (success) {
        emit(GetUserHistoryLoaded(parkHistoryModel: success));
      });
    } catch (failure) {
      emit(HomeError(failure: failure.toString()));
    }
  }
}
