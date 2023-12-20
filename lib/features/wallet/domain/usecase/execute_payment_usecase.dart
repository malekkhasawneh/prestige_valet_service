import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/wallet/domain/repository/wallet_repository.dart';

class ExecutePaymentUseCase
    extends UseCase<MFDirectPaymentResponse, ExecutePaymentUseCaseParams> {
  final WalletRepository repository;

  ExecutePaymentUseCase({required this.repository});

  @override
  Future<Either<Failures, MFDirectPaymentResponse>> call(
      ExecutePaymentUseCaseParams params) async {
    return await repository.executePayment(
        cardNumber: params.cardNumber,
        cardHolderName: params.cardHolderName,
        expiryDate: params.expiryDate,
        cvv: params.cvv,
        amount: params.amount);
  }
}

class ExecutePaymentUseCaseParams extends Equatable {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final String amount;

  const ExecutePaymentUseCaseParams(
      {required this.cardNumber,
      required this.cardHolderName,
      required this.expiryDate,
      required this.cvv,
      required this.amount});

  @override
  List<Object?> get props =>
      [cardNumber, cardHolderName, expiryDate, cvv, amount];
}
