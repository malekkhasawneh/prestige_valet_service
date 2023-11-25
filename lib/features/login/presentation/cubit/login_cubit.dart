import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/features/login/domain/usecase/login_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  final LoginUseCase loginUseCase;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _showPassword = false;

  bool get showPassword => _showPassword;

  set setShowPassword(bool value) {
    emit(SetValueLoading());
    _showPassword = value;
    emit(SetValueLoaded());
  }

  bool _mustCheck = false;

  bool get mustCheck => _mustCheck;

  set setMustCheck(bool value) {
    emit(SetValueLoading());
    _mustCheck = value;
    emit(SetValueLoaded());
  }

  Future<void> login() async {
    emit(LoginLoading());
    try {
      final response = await loginUseCase(LoginUseCaseParams(
          email: emailController.text, password: passwordController.text));
      response.fold(
          (failure) {
            log('====================================== Error ${failure.failure}');
            emit(LoginError(error: failure.failure));
          },
          (success) => emit(LoginLoaded(
                userModel: success,
              )));
    } catch (error) {
      log('====================================== Error ${error.toString()}');
      emit(LoginError(error: error.toString()));
    }
  }

  bool checkIfThereAreEmptyValue() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
