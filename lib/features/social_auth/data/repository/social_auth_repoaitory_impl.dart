import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/social_auth/data/datasource/social_auth_local_datasource.dart';
import 'package:prestige_valet_app/features/social_auth/data/datasource/social_auth_remote_datasource.dart';
import 'package:prestige_valet_app/features/social_auth/domain/repository/social_auth_repository.dart';

class SocialAuthRepositoryImpl implements SocialAuthRepository {
  final NetworkInfo networkInfo;
  final SocialAuthRemoteDataSource remoteDataSource;
  final SocialAuthLocalDataSource localDataSource;

  SocialAuthRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failures, UserCredential>> signInUsingFacebook() async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.signInUsingFacebook();
        return Right(response);
      } on ServerException catch (failure) {
        return Left(
          ServerFailure(
            failure: failure.toString(),
          ),
        );
      }
    } else {
      return Left(InternetFailure(failure: Strings.noInternetConnection()));
    }
  }

  @override
  Future<Either<Failures, UserCredential>> signInUsingGmail() async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.signInUsingGmail();
        return Right(response);
      } on ServerException catch (failure) {
        return Left(
          ServerFailure(
            failure: failure.toString(),
          ),
        );
      }
    } else {
      return Left(InternetFailure(failure: Strings.noInternetConnection()));
    }
  }

  @override
  Future<Either<Failures, String>> encryptUserId({required String userId}) async {
    try {
      final response = await localDataSource.encryptUserId(userId: userId);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure(failure: Strings.processFailed()));
    }
  }
}
