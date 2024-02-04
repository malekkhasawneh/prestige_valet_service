import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/wallet/data/datasource/wallet_local_datasource.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';
import 'package:prestige_valet_app/features/wallet/domain/repository/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletLocalDataSource localDataSource;

  WalletRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failures, List<WalletModel>>> getCards() async {
    try {
      final response = await localDataSource.getCards();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: Constants.cacheFailure));
    }
  }
}
