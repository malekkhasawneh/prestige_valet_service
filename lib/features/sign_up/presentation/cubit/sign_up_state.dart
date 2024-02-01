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
  final SignUpModel model;

  const SignUpLoaded({required this.model});
  @override
  List<Object> get props => [model];
}

class AccountActivatedLoaded extends SignUpState {
  final bool activatedState;

  const AccountActivatedLoaded({required this.activatedState});
  @override
  List<Object> get props => [activatedState];
}

class SignUpMissingData extends SignUpState {
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
