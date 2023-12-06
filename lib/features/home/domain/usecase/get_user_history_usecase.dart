import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';

class GetUserHistoryUseCase
    extends UseCase<ParkHistoryModel, GetUserHistoryUseCaseParams> {
  final HomeRepository repository;

  GetUserHistoryUseCase({required this.repository});

  @override
  Future<Either<Failures, ParkHistoryModel>> call(
      GetUserHistoryUseCaseParams params) async {
    return await repository.getUserHistory(userId: params.userId);
  }
}

class GetUserHistoryUseCaseParams extends Equatable {
  final int userId;

  const GetUserHistoryUseCaseParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
