import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/wallet/domain/repository/wallet_repository.dart';

class SendPaymentUseCase extends UseCase<bool, SendPaymentUseCaseParams> {
  final WalletRepository repository;

  SendPaymentUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(SendPaymentUseCaseParams params) async {
    return await repository.sendPayment(
        type: params.type,
        amount: params.amount,
        userId: params.userId,
        gateId: params.gateId,
        parkingId: params.parkingId);
  }
}

class SendPaymentUseCaseParams extends Equatable {
  final String type;
  final String amount;
  final int userId;
  final int gateId;
  final int parkingId;

  const SendPaymentUseCaseParams(
      {required this.type,
      required this.amount,
      required this.userId,
      required this.gateId,
      required this.parkingId});

  @override
  List<Object?> get props => [type, amount, userId, gateId, parkingId];
}
