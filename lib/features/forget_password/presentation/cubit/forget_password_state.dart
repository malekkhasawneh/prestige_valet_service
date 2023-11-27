part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();
}

class ForgetPasswordInitial extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class ForgetPasswordLoading extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class ForgetPasswordLoaded extends ForgetPasswordState {
  final ChangePasswordModel changePasswordModel;

 const ForgetPasswordLoaded({required this.changePasswordModel});
  @override
  List<Object> get props => [changePasswordModel];
}

class ForgetPasswordError extends ForgetPasswordState {
  final String failure;

  const ForgetPasswordError({required this.failure});

  @override
  List<Object> get props => [failure];
}
