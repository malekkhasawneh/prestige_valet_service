import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/splash/domain/repository/splash_repository.dart';

class SetIsFirstTimeOpenTheAppUseCase extends UseCase<void, NoParams> {
  final SplashRepository repository;

  SetIsFirstTimeOpenTheAppUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await repository.setIsFirstTimeOpenTheApp();
  }
}
