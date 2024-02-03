import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/login/domain/usecase/login_usecase.dart';
import 'package:prestige_valet_app/features/login/domain/usecase/login_with_facebook_usecase.dart';
import 'package:prestige_valet_app/features/login/domain/usecase/login_with_google_usecase.dart';
import 'package:prestige_valet_app/features/login/domain/usecase/login_with_twitter_usecase.dart';
import 'package:prestige_valet_app/features/login/domain/usecase/set_login_flag_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  LoginCubit({
    required this.loginUseCase,
    required this.setLoginFlagUseCase,
    required this.loginWithGoogleUseCase,
    required this.loginWithTwitterUseCase,
    required this.loginWithFacebookUseCase,
  }) : super(LoginInitial());

  final LoginUseCase loginUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LoginWithTwitterUseCase loginWithTwitterUseCase;
  final LoginWithFacebookUseCase loginWithFacebookUseCase;
  final SetLoginFlagUseCase setLoginFlagUseCase;

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
      response.fold((failure) {
        emit(LoginError(error: failure.failure));
      },
          (success) => emit(LoginLoaded(
                userModel: success,
              )));
    } catch (error) {
      emit(LoginError(error: error.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());
    try {
      final response = await loginWithGoogleUseCase(NoParams());
      response.fold((failure) {
        emit(LoginError(error: failure.failure));
      }, (success) async {
        emailController.text = success.user!.email ?? '';
        passwordController.text = '';
        await login();
      });
    } catch (error) {
      emit(LoginError(error: error.toString()));
    }
  }

  Future<void> loginWithTwitter() async {
    emit(LoginLoading());
    try {
      final response = await loginWithTwitterUseCase(NoParams());
      response.fold((failure) {
        emit(LoginError(error: failure.failure));
      }, (success) async {
        emailController.text = success.user!.email ?? '';
        passwordController.text = '';
        await login();
      });
    } catch (error) {
      emit(LoginError(error: error.toString()));
    }
  }

  Future<void> loginWithFacebook() async {
    emit(LoginLoading());
    try {
      final response = await loginWithFacebookUseCase(NoParams());
      response.fold((failure) {
        emit(LoginError(error: failure.failure));
      }, (success) async {
        emailController.text = success.user!.email ?? '';
        passwordController.text = '';
        await login();
      });
    } catch (error) {
      emit(LoginError(error: error.toString()));
    }
  }

  Future<void> setLoginFlag() async {
    emit(SetValueLoading());
    try {
      final response = await setLoginFlagUseCase(NoParams());
      response.fold((failure) => emit(LoginError(error: failure.failure)),
          (success) => emit(SetValueLoaded()));
    } catch (failure) {
      emit(LoginError(error: failure.toString()));
    }
  }

  bool checkIfThereAreEmptyValue() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        !checkEmailValidity()) {
      return true;
    } else {
      return false;
    }
  }

  bool checkEmailValidity() {
    if (emailController.text.contains('.com') &&
        emailController.text.contains('@')) {
      return true;
    } else {
      return false;
    }
  }
}
