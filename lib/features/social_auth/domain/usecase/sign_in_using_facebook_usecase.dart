import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/social_auth/domain/repository/social_auth_repository.dart';

class SignInUsingFacebookUseCase implements UseCase<UserCredential, NoParams> {
  final SocialAuthRepository repository;

  SignInUsingFacebookUseCase({required this.repository});

  @override
  Future<Either<Failures, UserCredential>> call(NoParams params) async {
    return await repository.signInUsingFacebook();
  }
}
