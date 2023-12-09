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

class SendResetPasswordOtpLoaded extends ForgetPasswordState {
  final SendOtpModel sendOtpModel;

  const SendResetPasswordOtpLoaded({required this.sendOtpModel});

  @override
  List<Object> get props => [sendOtpModel];
}

class ForgetPasswordError extends ForgetPasswordState {
  final String failure;

  const ForgetPasswordError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class VerifyOtpLoaded extends ForgetPasswordState {
  final bool isVerified;

  const VerifyOtpLoaded({required this.isVerified});

  @override
  List<Object> get props => [isVerified];
}

class VerifyOtpError extends ForgetPasswordState {
  final String failure;

  const VerifyOtpError({required this.failure});

  @override
  List<Object> get props => [failure];
}
class ChangePasswordError extends ForgetPasswordState {
  final String failure;

  const ChangePasswordError({required this.failure});

  @override
  List<Object> get props => [failure];
}
// Set And Get Values States
class SetValueLoading extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class SetValueLoaded extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}