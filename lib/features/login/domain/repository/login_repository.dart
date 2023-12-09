import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class LoginRepository {
  Future<Either<Failures, SignUpModel>> login(
      {required String email, required String password});
  Future<Either<Failures, UserCredential>> loginWithGoogle();

  Future<Either<Failures, void>> setLoginFlag();

  Future<Either<Failures, UserCredential>> signInWithTwitter();

  Future<Either<Failures, UserCredential>> signInWithFacebook();
}
