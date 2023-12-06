import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';

class GetValetHistoryUseCase
    extends UseCase<ParkHistoryModel, GetValetHistoryUseCaseParams> {
  final ValetRepository repository;

  GetValetHistoryUseCase({required this.repository});

  @override
  Future<Either<Failures, ParkHistoryModel>> call(
      GetValetHistoryUseCaseParams params) async {
    return await repository.getValetHistory(valetId: params.valetId);
  }
}

class GetValetHistoryUseCaseParams extends Equatable {
  final int valetId;

  const GetValetHistoryUseCaseParams({required this.valetId});

  @override
  List<Object?> get props => [valetId];
}
