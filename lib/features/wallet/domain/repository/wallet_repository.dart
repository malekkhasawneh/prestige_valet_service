import 'package:dartz/dartz.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';

abstract class WalletRepository{
  Future<Either<Failures,List<WalletModel>>> getCards({required int userId});
  Future<Either<Failures,MFDirectPaymentResponse>> executePayment(
      {required String cardNumber,
        required String cardHolderName,
        required String expiryDate,
        required String cvv,
        required String amount});
}