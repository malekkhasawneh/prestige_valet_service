import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';

abstract class AddCardRepository {
  Future<Either<Failures, bool>> addNewCard(
      {required int walletId,
      required String holderName,
      required String cardNumber,
      required String expiryDate,
      required bool isFromEdit});
}
