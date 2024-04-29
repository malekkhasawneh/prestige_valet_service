import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/valet/data/model/guest_price_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/retrieve_car_queue_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/valet_history_model.dart';

abstract class ValetRepository {
  Future<Either<Failures, ParkedCarsModel>> parkCar({required int valetId, required bool isGuest});
  Future<Either<Failures, ParkedCarsModel>> changeStatusToParked({required int parkingId});

  Future<Either<Failures, ParkedCarsModel>> carDelivered(
      {required int parkingId});

  Future<Either<Failures, ValetHistoryModel>> getValetHistory(
      {required int valetId});
  Future<Either<Failures, String>> getSlotNumber({required int valetId});
  Future<Either<Failures, RetrieveCarQueueModel>> getCarsQueue({required int valetId});
  Future<Either<Failures, void>> setCarStatusAsRetrieving(
      {required int valetId, required int parkingId});
  Future<Either<Failures,GuestPriceModel>> getGuestPrice(int valetId);

}
