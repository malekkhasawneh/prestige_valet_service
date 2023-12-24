import 'package:dartz/dartz.dart';
import 'package:myfatoorah_flutter/MFModels.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/wallet/data/datasource/wallet_remote_datasource.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';
import 'package:prestige_valet_app/features/wallet/domain/repository/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WalletRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, List<WalletModel>>> getCards(
      {required int userId}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.getCards(userId: userId);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, MFDirectPaymentResponse>> executePayment(
      {required String cardNumber,
      required String cardHolderName,
      required String expiryDate,
      required String cvv,
      required String amount}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.executePayment(
            cardNumber: cardNumber,
            cardHolderName: cardHolderName,
            expiryDate: expiryDate,
            cvv: cvv,
            amount: amount);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      throw const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }
}
