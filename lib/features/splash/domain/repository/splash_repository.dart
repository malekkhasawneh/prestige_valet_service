import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';

abstract class SplashRepository{
  Future<Either<Failures,bool>> checkIsUserLogin();
}