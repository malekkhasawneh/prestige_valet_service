import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class LoginRepository {
  Future<Either<Failures, UserModel>> login(
      {required String email, required String password});
}
