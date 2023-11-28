import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/usecase/check_is_user_login_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  SplashCubit({
    required this.checkIsUserLoginUseCase,
  }) : super(SplashInitial());

  final CheckIsUserLoginUseCase checkIsUserLoginUseCase;

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
}
