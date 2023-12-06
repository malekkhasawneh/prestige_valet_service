import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/repository/nav_repository.dart';

class MustResetNotificationTokenUseCase extends UseCase<bool, NoParams> {
  final NavRepository repository;

  MustResetNotificationTokenUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    return await repository.mustResetNotificationToken();
  }
}
