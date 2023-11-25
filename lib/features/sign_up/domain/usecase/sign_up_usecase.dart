import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';
import 'package:prestige_valet_app/features/sign_up/domain/repository/sign_up_repository.dart';

class SignUpUseCase extends UseCase<RegistrationModel, SignUpUseCaseParams> {
  final SignUpRepository repository;

  SignUpUseCase({required this.repository});

  @override
  Future<Either<Failures, RegistrationModel>> call(
      SignUpUseCaseParams params) async {
    return await repository.signUp(
      email: params.email,
      phone: params.phone,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
      socialProfile: params.socialProfile,
    );
  }
}

class SignUpUseCaseParams extends Equatable {
  final String email;
  final String phone;
  final String password;
  final String firstName;
  final String lastName;
  final bool socialProfile;

  const SignUpUseCaseParams(
      {required this.email,
      required this.phone,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.socialProfile});

  @override
  List<Object?> get props =>
      [email, phone, password, firstName, lastName, socialProfile];
}
