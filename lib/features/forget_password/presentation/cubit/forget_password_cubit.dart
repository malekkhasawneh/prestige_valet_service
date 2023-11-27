import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/change_password_model.dart';
import 'package:prestige_valet_app/features/forget_password/domain/usecase/chanege_password_usecase.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  static ForgetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);

  ForgetPasswordCubit({required this.changePasswordUseCase})
      : super(ForgetPasswordInitial());

  final ChangePasswordUseCase changePasswordUseCase;

  TextEditingController emailController = TextEditingController(text: 'malekmamoon341@gmail.com');
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> changePassword() async {
    try {
      final response = await changePasswordUseCase(ChangePasswordUseCaseParams(
          email: emailController.text, password: passwordController.text));
      response.fold(
        (failure) => emit(ForgetPasswordError(failure: failure.failure)),
        (success) => emit(
          ForgetPasswordLoaded(
            changePasswordModel: success,
          ),
        ),
      );
    } catch (failure) {
      emit(ForgetPasswordError(failure: failure.toString()));
    }
  }
}
