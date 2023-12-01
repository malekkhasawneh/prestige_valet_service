import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/add_credit_card/data/datasource/add_card_remote_datasource.dart';
import 'package:prestige_valet_app/features/add_credit_card/data/model/add_card_model.dart';
import 'package:prestige_valet_app/features/add_credit_card/domain/repository/add_card_repository.dart';

class AddCardRepositoryImpl implements AddCardRepository {
  final AddCardRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AddCardRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, AddCardModel>> addNewCard(
      {required int userId,
      required String holderName,
      required String cardNumber,
      required String month,
      required String year,
      required int walletId,
      required bool isFromEdit}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.addNewCard(
            userId: userId,
            walletId: walletId,
            holderName: holderName,
            cardNumber: cardNumber,
            month: month,
            year: year,
            isFromEdit: isFromEdit);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }
}
