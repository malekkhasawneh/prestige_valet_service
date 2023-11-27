part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  final SignUpModel userModel;

  const LoginLoaded({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class LoginError extends LoginState {
  final String error;

  const LoginError({required this.error});

  @override
  List<Object> get props => [error];
}

// Set And Get Value States
class SetValueLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class SetValueLoaded extends LoginState {
  @override
  List<Object> get props => [];
}
