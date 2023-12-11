import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/pick_up/data/model/gates_model.dart';

abstract class PickUpRepository{
  Future<Either<Failures,GatesModel>> getGates({required int locationId});
}