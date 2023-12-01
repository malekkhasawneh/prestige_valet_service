part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {
  final bool logout;

  const ProfileLoaded({required this.logout});

  @override
  List<Object> get props => [logout];
}

class ClearCacheState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileError extends ProfileState {
  final String failure;

  const ProfileError({required this.failure});

  @override
  List<Object> get props => [failure];
}
