import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';

class ParkCarUseCase extends UseCase<ParkedCarsModel, ParkCarUseCaseParams> {
  final ValetRepository repository;

  ParkCarUseCase({required this.repository});

  @override
  Future<Either<Failures, ParkedCarsModel>> call(
      ParkCarUseCaseParams params) async {
    return await repository.parkCar(
        valetId: params.valetId,
        userId: params.userId,
        parkingTypeId: params.parkingTypeId,
        isGuest: params.isGuest);
  }
}

class ParkCarUseCaseParams extends Equatable {
  final int valetId;
  final int userId;
  final int parkingTypeId;
  final bool isGuest;

  const ParkCarUseCaseParams(
      {required this.valetId,
      required this.userId,
      required this.parkingTypeId,
      required this.isGuest});

  @override
  List<Object?> get props => [valetId,isGuest];
}
