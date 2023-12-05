import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';

class CarDeliveredUseCase
    extends UseCase<ParkedCarsModel,CarDeliveredUseCaseParams> {
  final ValetRepository repository;

  CarDeliveredUseCase({required this.repository});

  @override
  Future<Either<Failures, ParkedCarsModel>> call(
      CarDeliveredUseCaseParams params) async {
    return await repository.carDelivered(parkingId: params.parkingId);
  }
}

class CarDeliveredUseCaseParams extends Equatable {
  final int parkingId;

  const CarDeliveredUseCaseParams({required this.parkingId});

  @override
  List<Object?> get props => [parkingId];
}
