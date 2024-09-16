import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/profile/domain/repository/profile_repository.dart';

class DeleteUserAccountUsecase extends UseCase<bool, NoParams> {
  final UserProfileRepository repository;

  DeleteUserAccountUsecase({required this.repository});
  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    return await repository.deleteUserAccount();
  }
}
