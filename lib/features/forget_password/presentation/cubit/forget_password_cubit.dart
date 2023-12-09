import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/change_password_model.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/send_otp_model.dart';
import 'package:prestige_valet_app/features/forget_password/domain/usecase/chanege_password_usecase.dart';
import 'package:prestige_valet_app/features/forget_password/domain/usecase/send_reset_password_usecase.dart';
import 'package:prestige_valet_app/features/forget_password/domain/usecase/verify_otp_usecase.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  static ForgetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);

  ForgetPasswordCubit({
    required this.changePasswordUseCase,
    required this.sendResetPasswordOtpUseCase,
    required this.verifyOtpUseCase,
  }) : super(ForgetPasswordInitial());

  final ChangePasswordUseCase changePasswordUseCase;
  final SendResetPasswordOtpUseCase sendResetPasswordOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String token = '';

  bool _mustCheck = false;

  bool get mustCheck => _mustCheck;

  set setMustCheck(bool value) {
    emit(SetValueLoading());
    _mustCheck = value;
    emit(SetValueLoaded());
  }

  Future<void> changePassword() async {
    emit(ForgetPasswordLoading());
    try {
      final response = await changePasswordUseCase(ChangePasswordUseCaseParams(
        email: emailController.text,
        password: passwordController.text,
        token: token,
      ));
      response.fold(
        (failure) {
          emit(ChangePasswordError(failure: failure.failure));
        },
        (success) {
          emit(
          ForgetPasswordLoaded(
            changePasswordModel: success,
          ),
        );
        },
      );
    } catch (failure) {
      emit(ChangePasswordError(failure: failure.toString()));
    }
  }

  Future<void> sendResetPasswordOtp() async {
    emit(ForgetPasswordLoading());
    try {
      final response =
          await sendResetPasswordOtpUseCase(SendResetPasswordOtpUseCaseParams(
        email: emailController.text,
      ));
      response.fold(
        (failure) {
          emit(ForgetPasswordError(failure: failure.failure));
        },
        (success) {
          emit(
            SendResetPasswordOtpLoaded(
              sendOtpModel: success,
            ),
          );
        },
      );
    } catch (failure) {
      emit(ForgetPasswordError(failure: failure.toString()));
    }
  }

  Future<void> verifyOtp({required String otp}) async {
    emit(ForgetPasswordLoading());
    try {
      final response = await verifyOtpUseCase(VerifyOtpUseCaseParams(
        email: emailController.text,
        otp: otp,
      ));
      response.fold(
        (failure) {
          emit(VerifyOtpError(failure: failure.failure));
        },
        (success) {
          token = otp;
          emit(
            VerifyOtpLoaded(
              isVerified: success,
            ),
          );
        },
      );
    } catch (failure) {
      emit(VerifyOtpError(failure: failure.toString()));
    }
  }

  bool isEmailEmpty() {
    return emailController.text.isEmpty;
  }

  bool isPasswordEmptyOrNotMatch() {
    return (passwordController.text.isEmpty ||
            confirmPasswordController.text.isEmpty) ||
        (passwordController.text != confirmPasswordController.text);
  }

  bool isPasswordDoesNotMatch() {
    return passwordController.text != confirmPasswordController.text;
  }
}
