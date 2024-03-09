import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/wallet/data/datasource/wallet_local_datasource.dart';
import 'package:prestige_valet_app/features/wallet/data/datasource/wallet_remote_datasource.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';
import 'package:prestige_valet_app/features/wallet/domain/repository/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletLocalDataSource localDataSource;
  final WalletRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WalletRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, List<WalletModel>>> getCards() async {
    try {
      final response = await localDataSource.getCards();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: Constants.cacheFailure));
    }
  }

  @override
  Future<Either<Failures, bool>> sendPayment(
      {required String type,
      required String amount,
      required int userId,
      required int gateId,
      required int parkingId}) async {
    if (await networkInfo.checkConnection()) {
      final response = await remoteDataSource.sendPayment(
          type: type,
          amount: amount,
          userId: userId,
          gateId: gateId,
          parkingId: parkingId);
      return Right(response);
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }
}
