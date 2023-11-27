import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/edit_profile/domain/repository/profile_repository.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

class EditProfileUseCase extends UseCase<User, EditProfileUseCaseParams> {
  final ProfileRepository repository;

  EditProfileUseCase({required this.repository});

  @override
  Future<Either<Failures, User>> call(
      EditProfileUseCaseParams params) async {
    return await repository.editProfile(
        userId: params.userId,
        firstName: params.firstName,
        lastName: params.lastName,
        phone: params.phone,
        email: params.email);
  }
}

class EditProfileUseCaseParams extends Equatable {
  final int userId;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;

  const EditProfileUseCaseParams({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
  });

  @override
  List<Object?> get props => [];
}
