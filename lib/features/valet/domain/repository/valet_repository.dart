import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';

abstract class ValetRepository {
  Future<Either<Failures, ParkedCarsModel>> parkCar({required int valetId, required bool isGuest});
  Future<Either<Failures, ParkedCarsModel>> changeStatusToParked({required int parkingId});
  Future<Either<Failures, ParkedCarsModel>> carDelivered({required int parkingId});
  Future<Either<Failures, ParkHistoryModel>> getValetHistory({required int valetId});

}
