import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/profile/domain/repository/profile_repository.dart';

class ClearCacheUseCase extends UseCase<void, NoParams> {
  final UserProfileRepository repository;

  ClearCacheUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await repository.clearCache();
  }
}
