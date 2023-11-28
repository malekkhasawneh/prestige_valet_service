import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/add_credit_card/data/model/add_card_model.dart';

abstract class AddCardRepository {
  Future<Either<Failures, AddCardModel>> addNewCard(
      {required int userId,
      required String holderName,
      required String cardNumber,
      required String month,
      required String year});
}
