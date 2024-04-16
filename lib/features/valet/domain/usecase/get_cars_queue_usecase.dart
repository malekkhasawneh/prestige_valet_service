import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/valet/data/model/retrieve_car_queue_model.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';

class GetCarsQueueUseCase
    extends UseCase<RetrieveCarQueueModel, GetCarsQueueUseCaseParams> {
  final ValetRepository repository;

  GetCarsQueueUseCase({required this.repository});

  @override
  Future<Either<Failures, RetrieveCarQueueModel>> call(
      GetCarsQueueUseCaseParams params) async {
    return await repository.getCarsQueue(valetId: params.valetId);
  }
}

class GetCarsQueueUseCaseParams extends Equatable {
  final int valetId;

  const GetCarsQueueUseCaseParams({required this.valetId});

  @override
  List<Object?> get props => [valetId];
}
