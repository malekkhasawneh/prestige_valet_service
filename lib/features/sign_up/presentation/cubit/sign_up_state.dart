part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoaded extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpError extends SignUpState {
  final String failure;

 const SignUpError({required this.failure});
  @override
  List<Object> get props => [failure];
}

// Set And Get Value States
class SetValueLoading extends SignUpState {
  @override
  List<Object> get props => [];
}
class SetValueLoaded extends SignUpState {
  @override
  List<Object> get props => [];
}
