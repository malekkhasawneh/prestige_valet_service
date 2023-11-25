import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/sign_up/domain/usecase/set_user_model_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/domain/usecase/sign_in_with_google_usecase.dart';
import 'package:prestige_valet_app/features/sign_up/domain/usecase/sign_up_usecase.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  static SignUpCubit get(BuildContext context) => BlocProvider.of(context);

  SignUpCubit({
    required this.signUpUseCase,
    required this.signInWithGoogleUseCase,
    required this.setUserModelUseCase,
  }) : super(SignUpInitial());

  final SignUpUseCase signUpUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SetUserModelUseCase setUserModelUseCase;

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

  bool hideNormalAuthField = false;

  Future<void> signUp(
      {bool socialProfile = false, String imageUrl = ""}) async {
    emit(SignUpLoading());
    if (checkIfThereAreAnyMissingData()) {}
    try {
      final response = await signUpUseCase(
        SignUpUseCaseParams(
          email: emailController.text,
          phone: phoneController.text,
          password: passwordController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          socialProfile: socialProfile,
          imageUrl: imageUrl,
        ),
      );
      response.fold((failure) {
        emit(SignUpError(failure: failure.failure));
      }, (success) {
        setUserModel(userModel: jsonEncode(success.toJson()));
        emit(SetValueLoaded());
      });
    } catch (failure) {
      emit(SignUpError(failure: failure.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(SignUpLoading());
    try {
      final response = await signInWithGoogleUseCase(
        NoParams(),
      );
      response.fold((failure) {
        emit(SignUpError(failure: failure.failure));
      }, (success) {
        firstNameController.text =
            success.user!.displayName!.split(' ').first ?? '';
        lastNameController.text =
            success.user!.displayName!.split(' ').last ?? '';
        phoneController.text = success.user!.phoneNumber ?? '';
        emailController.text = success.user!.email ?? '';
        if (checkIfThereAreAnyMissingDataForSocial()) {
          hideNormalAuthField = true;
          emit(SignUpMissingData());
        } else {
          signUp(socialProfile: true, imageUrl: success.user!.photoURL ?? "");
          emit(SetValueLoaded());
        }
      });
    } catch (failure) {
      emit(SignUpError(failure: failure.toString()));
    }
  }

  Future<void> setUserModel({required String userModel}) async {
    emit(SignUpLoading());
    try {
      final response = await setUserModelUseCase(
        SetUserModelUseCaseParams(userModel: userModel),
      );
      response.fold((failure) {
        emit(SignUpError(failure: failure.failure));
      }, (success) {});
    } catch (failure) {
      emit(SignUpError(failure: failure.toString()));
    }
  }

  bool checkIfThereAreAnyMissingDataForSocial() {
    if (emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool checkIfThereAreAnyMissingData() {
    if (emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
