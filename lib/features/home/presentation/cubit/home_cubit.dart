import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/home/domain/usecase/get_user_data_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  HomeCubit({
    required this.getUserDataUseCase,
  }) : super(HomeInitial());

  final GetUserDataUseCase getUserDataUseCase;

  double bodyBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.7) - 56;

  double headerBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.3) - 2;

  late UserModel userModel;

  Future<void> getUserData() async {
    emit(HomeLoading());
    try {
      final response = await getUserDataUseCase(NoParams());
      response.fold((failure) => emit(HomeError(failure: failure.toString())),
          (userModel) {
        this.userModel = userModel;
            emit(HomeLoaded());
          });
    } catch (failure) {
      emit(HomeError(failure: failure.toString()));
    }
  }
}
