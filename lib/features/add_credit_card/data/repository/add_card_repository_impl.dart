import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/add_credit_card/data/datasource/add_card_local_datasource.dart';
import 'package:prestige_valet_app/features/add_credit_card/data/model/add_card_model.dart';
import 'package:prestige_valet_app/features/add_credit_card/domain/repository/add_card_repository.dart';

class AddCardRepositoryImpl implements AddCardRepository {
  final AddCardLocalDataSource localDataSource;

  AddCardRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failures, bool>> addNewCard(
      {required String holderName,
      required String cardNumber,
      required String expiryDate,
      required int walletId,
      required bool isFromEdit}) async {
    try {
      final response = await localDataSource.addNewCard(
          walletId: walletId,
          holderName: holderName,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          isFromEdit: isFromEdit);
      return Right(response);
    } on ServerException {
      return const Left(ServerFailure(failure: Constants.serverFailure));
    }
  }
}
