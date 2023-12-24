import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';

class CheckInternetConnectionUseCase extends UseCase<bool, NoParams> {
  final HomeRepository repository;

  CheckInternetConnectionUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    return await repository.checkInternetConnection();
  }
}
