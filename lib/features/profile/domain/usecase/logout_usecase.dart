import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/profile/domain/repository/profile_repository.dart';

class LogoutUseCase extends UseCase<bool, LogoutUseCaseParams> {
  final UserProfileRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(LogoutUseCaseParams params) async {
    return await repository.logout(userId: params.userId);
  }
}

class LogoutUseCaseParams extends Equatable {
  final int userId;

  const LogoutUseCaseParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
