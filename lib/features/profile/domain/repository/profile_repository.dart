import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';

abstract class UserProfileRepository{
  Future<Either<Failures,bool>> logout({required int userId});
  Future<Either<Failures,void>> clearCache();
}