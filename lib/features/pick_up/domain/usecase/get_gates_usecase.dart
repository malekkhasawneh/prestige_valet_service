import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/pick_up/data/model/gates_model.dart';
import 'package:prestige_valet_app/features/pick_up/domain/repository/pick_up_repository.dart';

class GetGatesUseCase extends UseCase<GatesModel, NoParams> {
  final PickUpRepository repository;

  GetGatesUseCase({required this.repository});

  @override
  Future<Either<Failures, GatesModel>> call(NoParams params) async {
    return await repository.getGates();
  }
}
