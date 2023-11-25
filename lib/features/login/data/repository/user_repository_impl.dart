import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/login/data/datasource/login_remote_datasource.dart';
import 'package:prestige_valet_app/features/login/domain/repository/login_repository.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, UserModel>> login(
      {required String email, required String password}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
            await remoteDataSource.login(email: email, password: password);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, UserCredential>> loginWithGoogle() async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.loginWithGoogle();
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(ServerFailure(failure: Constants.internetFailure));
    }
  }
}
