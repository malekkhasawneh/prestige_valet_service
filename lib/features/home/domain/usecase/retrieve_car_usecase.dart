import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

class RetrieveCarUseCase
    extends UseCase<ParkedCarsModel, RetrieveCarUseCaseParams> {
  final HomeRepository repository;

  RetrieveCarUseCase({required this.repository});

  @override
  Future<Either<Failures, ParkedCarsModel>> call(
      RetrieveCarUseCaseParams params) async {
    return await repository.retrieveCar(parkingId: params.parkingId);
  }
}

class RetrieveCarUseCaseParams extends Equatable {
  final int parkingId;

  const RetrieveCarUseCaseParams({required this.parkingId});

  @override
  List<Object?> get props => [parkingId];
}
