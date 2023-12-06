import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/valet/data/datasource/valet_remote_datasource.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';

class ValetRepositoryImpl implements ValetRepository {
  final ValetRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ValetRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, ParkedCarsModel>> parkCar(
      {required int valetId}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.parkCar(valetId: valetId);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, ParkedCarsModel>> changeStatusToParked(
      {required int parkingId}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
            await remoteDataSource.changeStatusToParked(parkingId: parkingId);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, ParkedCarsModel>> carDelivered(
      {required int parkingId}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
            await remoteDataSource.carDelivered(parkingId: parkingId);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, ParkHistoryModel>> getValetHistory({required int valetId})async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
        await remoteDataSource.getValetHistory(valetId: valetId);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }
}
