part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();
}

class EditProfileInitial extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileLoading extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileLoaded extends EditProfileState {
  final User userModel;

 const EditProfileLoaded({required this.userModel});
  @override
  List<Object> get props => [userModel];
}

class EditProfileError extends EditProfileState {
  final String failure;

  const EditProfileError({required this.failure});

  @override
  List<Object> get props => [failure];
}
