import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';

abstract class SplashRepository {
  Future<Either<Failures, bool>> checkIsUserLogin();

  Future<Either<Failures, bool>> isFirstTimeOpenTheApp();

  Future<Either<Failures, void>> setIsFirstTimeOpenTheApp();

  Future<Either<Failures, bool>> isUser();

  Future<Either<Failures, bool>> isFirstOpining();
}