import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';

abstract class SocialAuthRepository{
  Future<Either<Failures,UserCredential>> signInUsingGmail();
  Future<Either<Failures,UserCredential>> signInUsingFacebook();
  Future<Either<Failures,String>> encryptUserId({required String userId});
}