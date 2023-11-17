part of 'social_auth_cubit.dart';

abstract class SocialAuthState extends Equatable {
  const SocialAuthState();
}

class SocialAuthInitial extends SocialAuthState {
  @override
  List<Object> get props => [];
}

class SocialAuthLoading extends SocialAuthState {
  @override
  List<Object> get props => [];
}

class SocialAuthLoaded extends SocialAuthState {
  final UserCredential userModel;

  const SocialAuthLoaded({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class SocialAuthError extends SocialAuthState {
  final String failure;

  const SocialAuthError({required this.failure});

  @override
  List<Object> get props => [failure];
}

// Encrypt User Id States
class SocialAuthEncryptUserIdLoading extends SocialAuthState {
  @override
  List<Object> get props => [];
}

class SocialAuthEncryptUserIdLoaded extends SocialAuthState {
  @override
  List<Object> get props => [];
}

class SocialAuthEncryptUserIdError extends SocialAuthState {
  final String failure;

  const SocialAuthEncryptUserIdError({required this.failure});

  @override
  List<Object> get props => [failure];
}
