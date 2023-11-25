import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class SignUpRepository {
  Future<Either<Failures, RegistrationModel>> signUp({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required bool socialProfile,
  });
}
