import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/forget_password/data/datasource/change_password_remote_datasource.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/change_password_model.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/send_otp_model.dart';
import 'package:prestige_valet_app/features/forget_password/domain/repository/change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChangePasswordRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, ChangePasswordModel>> changePassword(
      {required String password,required String token, required String email}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.changePassword(
            password: password, email: email,token: token);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, SendOtpModel>> sendResetPasswordOtp(
      {required String email}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
            await remoteDataSource.sendResetPasswordOtp(email: email);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, bool>> verifyOtp(
      {required String email, required String otp}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
            await remoteDataSource.verifyOtp(email: email, otp: otp);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }
}
