import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/sign_up/domain/repository/sign_up_repository.dart';

class SignInWithGoogleUseCase extends UseCase<UserCredential, NoParams> {
  final SignUpRepository repository;

  SignInWithGoogleUseCase({required this.repository});

  @override
  Future<Either<Failures, UserCredential>> call(NoParams params) async {
    return await repository.signInWithGoogle();
  }
}
