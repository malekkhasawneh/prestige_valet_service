import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';

abstract class WalletRepository{
  Future<Either<Failures, List<WalletModel>>> getCards();

  Future<Either<Failures, bool>> sendPayment(
      {required String type,
      required String amount,
      required int userId,
      required int gateId,
      required int parkingId});
}