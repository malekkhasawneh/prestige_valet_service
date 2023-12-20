import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/datasource/nav_local_datasource.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/datasource/nav_remote_datasouce.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/data/model/notification_model.dart';
import 'package:prestige_valet_app/features/bottom_navigation_bar/domain/repository/nav_repository.dart';

class NavRepositoryImpl implements NavRepository {
  final NavRemoteDataSource remoteDataSource;
  final NavLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NavRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failures, NotificationModel>> getNotificationTokenByUserId(
      {required int userId}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
            await remoteDataSource.getNotificationTokenByUserId(userId: userId,);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, NotificationModel>> addNotificationToken(
      {required int userId, required String token}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.addNotificationToken(
            token: token, userId: userId);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, NotificationModel>> updateNotificationToken(
      {required int userId,
      required String token,
      required int tokenId}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.updateNotificationToken(
          userId: userId,
          tokenId: tokenId,
          token: token,
        );
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, bool>> mustResetNotificationToken() async {
    try {
      final response = await localDataSource.mustResetNotificationToken();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: Constants.cacheFailure));
    }
  }
}
