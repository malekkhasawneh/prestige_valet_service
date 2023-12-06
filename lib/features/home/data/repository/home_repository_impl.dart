import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/home/data/datasource/home_local_datasource.dart';
import 'package:prestige_valet_app/features/home/data/datasource/home_remote_datasource.dart';
import 'package:prestige_valet_app/features/home/domain/repository/home_repository.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, SignUpModel>> getUserData() async {
    try {
      final response = await localDataSource.getUserData();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: Constants.cacheFailure));
    }
  }

  @override
  Future<Either<Failures, ParkedCarsModel>> retrieveCar(
      {required int parkingId}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
            await remoteDataSource.retrieveCar(parkingId: parkingId);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, ParkedCarsModel>> washCar(
      {required int parkingId, required bool washFlag}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.washCar(
            parkingId: parkingId, washFlag: washFlag);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, ParkHistoryModel>> getUserHistory(
      {required int userId}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.getUserHistory(userId: userId);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

}
