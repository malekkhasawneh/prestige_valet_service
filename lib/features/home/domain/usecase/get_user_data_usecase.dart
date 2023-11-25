import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

class GetUserDataUseCase extends UseCase<UserModel, NoParams> {
  final HomeRepository repository;

  GetUserDataUseCase({required this.repository});

  @override
  Future<Either<Failures, UserModel>> call(NoParams params) async {
    return await repository.getUserData();
  }
}
