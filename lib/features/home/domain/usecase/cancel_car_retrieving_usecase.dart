import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

class CancelCarRetrievingUseCase
    extends UseCase<ParkedCarsModel, CancelCarRetrievingUseCaseParams> {
  final HomeRepository repository;

  CancelCarRetrievingUseCase({required this.repository});

  @override
  Future<Either<Failures, ParkedCarsModel>> call(
      CancelCarRetrievingUseCaseParams params) async {
    return await repository.cancelCarRetrieving(
      parkingId: params.parkingId,
    );
  }
}

class CancelCarRetrievingUseCaseParams extends Equatable {
  final int parkingId;

  const CancelCarRetrievingUseCaseParams({required this.parkingId});

  @override
  List<Object?> get props => [parkingId];
}
