import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';

class SetCarStatusAsRetrievingUseCase
    extends UseCase<void, SetCarStatusAsRetrievingUseCaseParams> {
  final ValetRepository repository;

  SetCarStatusAsRetrievingUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(
      SetCarStatusAsRetrievingUseCaseParams params) async {
    return await repository.setCarStatusAsRetrieving(
        valetId: params.valetId, parkingId: params.parkingId);
  }
}

class SetCarStatusAsRetrievingUseCaseParams extends Equatable {
  final int valetId;
  final int parkingId;

  const SetCarStatusAsRetrievingUseCaseParams(
      {required this.valetId, required this.parkingId});

  @override
  List<Object?> get props => [valetId, parkingId];
}
