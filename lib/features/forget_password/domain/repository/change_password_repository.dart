import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/change_password_model.dart';

abstract class ChangePasswordRepository{
  Future<Either<Failures,ChangePasswordModel>> changePassword(
      {required String password, required String email});
}