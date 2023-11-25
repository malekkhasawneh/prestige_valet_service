import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/features/sign_up/domain/usecase/sign_up_usecase.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  static SignUpCubit get(BuildContext context) => BlocProvider.of(context);

  SignUpCubit({required this.signUpUseCase}) : super(SignUpInitial());

  final SignUpUseCase signUpUseCase;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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

  Future<void> signUp({bool socialProfile = false}) async {
    emit(SignUpLoading());
    try {
      final response = await signUpUseCase(SignUpUseCaseParams(
          email: emailController.text,
          phone: phoneController.text,
          password: passwordController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          socialProfile: socialProfile));
      response.fold((failure) {
        log('=============================== failure ${failure.failure}');
        emit(SignUpError(failure: failure.toString()));
      },
          (success) {
            log('======================================== response ${success.token}');
            log('======================================== response ${success.id}');
            log('======================================== response ${success.role}');
            emit(SetValueLoaded());
          });
    } catch (failure) {
      emit(SignUpError(failure: failure.toString()));
    }
  }
}
