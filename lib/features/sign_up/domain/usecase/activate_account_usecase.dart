import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/sign_up/domain/repository/sign_up_repository.dart';

class ActivateAccountUseCase
    extends UseCase<bool, ActivateAccountUseCaseParams> {
  final SignUpRepository repository;

  ActivateAccountUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(
      ActivateAccountUseCaseParams params) async {
    return await repository.activateAccount(
      email: params.email,
      token: params.token,
    );
  }
}

class ActivateAccountUseCaseParams extends Equatable {
  final String email;
  final String token;

  const ActivateAccountUseCaseParams(
      {required this.email, required this.token});

  @override
  List<Object?> get props => [email, token];
}
