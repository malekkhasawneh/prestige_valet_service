import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/check_is_user_login_usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/get_is_first_time_usecae.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/is_first_opening_usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/is_user_usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/set_is_first_time_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  SplashCubit({
    required this.checkIsUserLoginUseCase,
    required this.setIsFirstTimeOpenTheAppUseCase,
    required this.getIsFirstTimeOpenTheAppUseCase,
    required this.isUserUseCase,
    required this.isFirstOpeningUseCase,
  }) : super(SplashInitial());

  final CheckIsUserLoginUseCase checkIsUserLoginUseCase;
  final SetIsFirstTimeOpenTheAppUseCase setIsFirstTimeOpenTheAppUseCase;
  final GetIsFirstTimeOpenTheAppUseCase getIsFirstTimeOpenTheAppUseCase;
  final IsUserUseCase isUserUseCase;
  final IsFirstOpeningUseCase isFirstOpeningUseCase;
  bool isFirstTime = false;
  bool isFirstOpining = false;
  bool isUser = false;

  Future<void> checkIfUserLogin() async {
    emit(SplashLoading());
    try {
      final response = await checkIsUserLoginUseCase(NoParams());
      response.fold((failure) => emit(SplashError(failure: failure.failure)),
          (success) => emit(SplashLoaded(isLogin: success)));
    } catch (failure) {
      emit(SplashError(failure: failure.toString()));
    }
  }

  Future<void> setIsFirstTimeOpenTheApp() async {
    emit(SplashLoading());
    try {
      final response = await setIsFirstTimeOpenTheAppUseCase(NoParams());
      response.fold((failure) => emit(SplashError(failure: failure.failure)),
          (success) => emit(const SplashSetValue()));
    } catch (failure) {
      emit(SplashError(failure: failure.toString()));
    }
  }

  Future<void> getIsFirstTimeOpenTheApp() async {
    emit(SplashLoading());
    try {
      final response = await getIsFirstTimeOpenTheAppUseCase(NoParams());
      response.fold((failure) => emit(SplashError(failure: failure.failure)),
          (success) {
        isFirstTime = success;
        emit(const SplashSetValue());
      });
    } catch (failure) {
      emit(SplashError(failure: failure.toString()));
    }
  }

  Future<void> checkIsUser() async {
    emit(SplashLoading());
    try {
      final response = await isUserUseCase(NoParams());
      response.fold((failure) => emit(SplashError(failure: failure.failure)),
          (success) {
        isUser = success;
        emit(const SplashSetValue());
      });
    } catch (failure) {
      emit(SplashError(failure: failure.toString()));
    }
  }

  Future<void> isFirstOpening() async {
    emit(SplashLoading());
    try {
      final response = await isFirstOpeningUseCase(NoParams());
      response.fold((failure) => emit(SplashError(failure: failure.failure)),
          (success) {
        isFirstOpining = success;
        emit(const SplashLoaded(isLogin: false));
      });
    } catch (error) {
      emit(SplashError(failure: error.toString()));
    }
  }
}
