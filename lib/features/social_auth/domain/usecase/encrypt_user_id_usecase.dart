import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/social_auth/domain/repository/social_auth_repository.dart';

class EncryptUserIdUseCase extends UseCase<String, EncryptUserIdUseCaseParams> {
  final SocialAuthRepository repository;

  EncryptUserIdUseCase({required this.repository});

  @override
  Future<Either<Failures, String>> call(
      EncryptUserIdUseCaseParams params) async {
    return await repository.encryptUserId(userId: params.userId);
  }
}

class EncryptUserIdUseCaseParams extends Equatable {
  final String userId;

  const EncryptUserIdUseCaseParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
