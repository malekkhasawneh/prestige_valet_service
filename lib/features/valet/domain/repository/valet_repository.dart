import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/valet/data/model/parked_cars_model.dart';

abstract class ValetRepository {
  Future<Either<Failures, ParkedCarsModel>> parkCar({required int valetId});
}
