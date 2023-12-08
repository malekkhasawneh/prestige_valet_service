import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/change_password_model.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/send_otp_model.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failures, SendOtpModel>> sendResetPasswordOtp(
      {required String email});

  Future<Either<Failures, bool>> verifyOtp(
      {required String email, required String otp});

  Future<Either<Failures, ChangePasswordModel>> changePassword(
      {required String password, required String token,required String email});
}