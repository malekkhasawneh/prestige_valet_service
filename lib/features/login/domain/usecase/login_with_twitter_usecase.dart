import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/login/domain/repository/login_repository.dart';

class LoginWithTwitterUseCase extends UseCase<UserCredential, NoParams> {
  final LoginRepository repository;

  LoginWithTwitterUseCase({required this.repository});

  @override
  Future<Either<Failures, UserCredential>> call(NoParams params) async {
    return await repository.signInWithTwitter();
  }
}
