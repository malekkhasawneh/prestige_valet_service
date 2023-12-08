import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/change_password_model.dart';
import 'package:prestige_valet_app/features/forget_password/domain/repository/change_password_repository.dart';

class ChangePasswordUseCase
    extends UseCase<ChangePasswordModel, ChangePasswordUseCaseParams> {
  final ChangePasswordRepository repository;

  ChangePasswordUseCase({required this.repository});

  @override
  Future<Either<Failures, ChangePasswordModel>> call(
      ChangePasswordUseCaseParams params) async {
    return await repository.changePassword(
        password: params.password, email: params.email, token: '');
  }
}

class ChangePasswordUseCaseParams extends Equatable {
  final String email;
  final String token;
  final String password;

  const ChangePasswordUseCaseParams(
      {required this.email, required this.password,required this.token});

  @override
  List<Object?> get props => [email, password,token];
}
