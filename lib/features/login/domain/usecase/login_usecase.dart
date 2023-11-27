import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/login/domain/repository/login_repository.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

class LoginUseCase extends UseCase<SignUpModel, LoginUseCaseParams> {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failures, SignUpModel>> call(LoginUseCaseParams params) async {
    return await repository.login(
        email: params.email, password: params.password);
  }
}

class LoginUseCaseParams extends Equatable {
  final String email;
  final String password;

  const LoginUseCaseParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
