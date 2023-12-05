import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';

class ChangeParkStatusUseCase
    extends UseCase<ParkedCarsModel, ChangeParkStatusUseCaseParams> {
  final ValetRepository repository;

  ChangeParkStatusUseCase({required this.repository});

  @override
  Future<Either<Failures, ParkedCarsModel>> call(
      ChangeParkStatusUseCaseParams params) async {
    return await repository.changeStatusToParked(parkingId: params.parkingId);
  }
}

class ChangeParkStatusUseCaseParams extends Equatable {
  final int parkingId;

  const ChangeParkStatusUseCaseParams({required this.parkingId});

  @override
  List<Object?> get props => [parkingId];
}
