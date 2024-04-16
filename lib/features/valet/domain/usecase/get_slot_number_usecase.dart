import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';

class GetSlotNumberUseCase extends UseCase<String, GetSlotNumberUseCaseParams> {
  final ValetRepository repository;

  GetSlotNumberUseCase({required this.repository});

  @override
  Future<Either<Failures, String>> call(
      GetSlotNumberUseCaseParams params) async {
    return await repository.getSlotNumber(valetId: params.valetId);
  }
}

class GetSlotNumberUseCaseParams extends Equatable {
  final int valetId;

  const GetSlotNumberUseCaseParams({required this.valetId});

  @override
  List<Object?> get props => [valetId];
}
