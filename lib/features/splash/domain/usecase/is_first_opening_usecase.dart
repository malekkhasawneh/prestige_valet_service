import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/repository/splash_repository.dart';

class IsFirstOpeningUseCase extends UseCase<bool, NoParams> {
  final SplashRepository repository;

  IsFirstOpeningUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    return await repository.isFirstOpining();
  }
}
