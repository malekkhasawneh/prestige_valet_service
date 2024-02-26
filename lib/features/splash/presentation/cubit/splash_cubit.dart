import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/check_is_user_login_usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/get_is_first_time_usecae.dart';
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
  }) : super(SplashInitial());

  final CheckIsUserLoginUseCase checkIsUserLoginUseCase;
  final SetIsFirstTimeOpenTheAppUseCase setIsFirstTimeOpenTheAppUseCase;
  final GetIsFirstTimeOpenTheAppUseCase getIsFirstTimeOpenTheAppUseCase;
  final IsUserUseCase isUserUseCase;
  bool isFirstTime = false;
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

  bool isUserBlocked = false;

  Future<void> isBlocked() async {
    try {
      final String basicAuth =
          'Basic ${base64Encode(utf8.encode('malek_mamoon123456456:!@#QWE123qwe'))}';

      Map<String, String> myHeaders = {'authorization': basicAuth};
      Dio dio = Dio(BaseOptions(headers: myHeaders));
      Response response = await dio.get(
        'https://doctoral-nation.000webhostapp.com/block_user.php',
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.data);
        log('======================================== ${data['data']['isBlocked']}');
        if (data['data']['isBlocked'] == '1') {
          isUserBlocked = true;
        } else {
          isUserBlocked = false;
        }
      } else {
        isUserBlocked = false;
      }
    } on Exception {
      isUserBlocked = false;
    }
  }
}
