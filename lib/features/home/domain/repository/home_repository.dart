import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

abstract class HomeRepository {
  Future<Either<Failures, SignUpModel>> getUserData();

  Future<Either<Failures, ParkedCarsModel>> retrieveCar(
      {required int parkingId,required int gateId});

  Future<Either<Failures, ParkedCarsModel>> washCar(
      {required int parkingId, required bool washFlag});

  Future<Either<Failures, ParkHistoryModel>> getUserHistory({
    required int userId,
  });
  Future<Either<Failures,bool>> sendNotification({
    required String title,
    required String body,
    required String notificationType,
    required String token,
  });

}
