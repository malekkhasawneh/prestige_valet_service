import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/splash/data/datasource/splash_local_datasource.dart';
import 'package:prestige_valet_app/features/splash/domain/repository/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository{
  final SplashLocalDataSource localDataSource;

  SplashRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failures, bool>> checkIsUserLogin() async {
    try {
      final response = await localDataSource.checkIsUserLogin();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: Constants.cacheFailure));
    }
  }

  @override
  Future<Either<Failures, bool>> isFirstTimeOpenTheApp() async {
    try {
      final response = await localDataSource.isFirstTimeOpenTheApp();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: Constants.cacheFailure));
    }
  }

  @override
  Future<Either<Failures, void>> setIsFirstTimeOpenTheApp() async {
    try {
      final response = await localDataSource.setIsFirstTimeOpenTheApp();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: Constants.cacheFailure));
    }
  }

  @override
  Future<Either<Failures, bool>> isUser() async {
    try {
      final response = await localDataSource.isUser();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: Constants.cacheFailure));
    }
  }

  @override
  Future<Either<Failures, bool>> isFirstOpining() async{
    try {
      final response = await localDataSource.isFirstOpining();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: Constants.cacheFailure));
    }
  }
}