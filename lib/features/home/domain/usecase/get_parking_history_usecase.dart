import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/home/data/model/payment_history_model.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';

class GetParkingHistoryUseCase
    extends UseCase<PaymentHistoryModel, GetParkingHistoryUseCaseParams> {
  final HomeRepository repository;

  GetParkingHistoryUseCase({required this.repository});

  @override
  Future<Either<Failures, PaymentHistoryModel>> call(
      GetParkingHistoryUseCaseParams params) async {
    return await repository.getParkingHistory(userId: params.userId);
  }
}

class GetParkingHistoryUseCaseParams extends Equatable {
  final int userId;

  const GetParkingHistoryUseCaseParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
