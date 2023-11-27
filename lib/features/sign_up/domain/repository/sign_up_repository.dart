import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

abstract class SignUpRepository {
  Future<Either<Failures, SignUpModel>> signUp({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required bool socialProfile,
    required String imageUrl,
  });

  Future<Either<Failures, UserCredential>> signInWithGoogle();

  Future<Either<Failures, void>> setUserModel({required String userModel});
}
