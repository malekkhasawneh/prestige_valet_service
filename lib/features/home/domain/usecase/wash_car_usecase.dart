import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

class WashCarUseCase extends UseCase<ParkedCarsModel, WashCarUseCaseParams> {
  final HomeRepository repository;

  WashCarUseCase({required this.repository});

  @override
  Future<Either<Failures, ParkedCarsModel>> call(
      WashCarUseCaseParams params) async {
    return await repository.washCar(
        parkingId: params.parkingId, washFlag: params.washFlag);
  }
}

class WashCarUseCaseParams extends Equatable {
  final int parkingId;
  final bool washFlag;

  const WashCarUseCaseParams({required this.parkingId, required this.washFlag});

  @override
  List<Object?> get props => [parkingId, washFlag];
}
