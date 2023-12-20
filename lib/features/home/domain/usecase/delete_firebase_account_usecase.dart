import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';

class DeleteFirebaseAccountUseCase extends UseCase<void, NoParams> {
  final HomeRepository repository;

  DeleteFirebaseAccountUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await repository.deleteUserAccountFomFirebase();
  }
}
