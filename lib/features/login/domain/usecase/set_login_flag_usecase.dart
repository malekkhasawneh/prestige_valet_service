import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/login/domain/repository/login_repository.dart';

class SetLoginFlagUseCase extends UseCase<void, NoParams> {
  final LoginRepository repository;

  SetLoginFlagUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await repository.setLoginFlag();
  }
}
