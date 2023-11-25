import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/sign_up/data/datasource/sign_up_local_datasource.dart';
import 'package:prestige_valet_app/features/sign_up/data/datasource/sign_up_remote_datasource.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';
import 'package:prestige_valet_app/features/sign_up/domain/repository/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource signUpRemoteDataSource;
  final SignUpLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SignUpRepositoryImpl({
    required this.signUpRemoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, RegistrationModel>> signUp({
    required String email,
    required String phone,
    required String password,
    required String firstName,
    required String lastName,
    required String imageUrl,
    required bool socialProfile,
  }) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await signUpRemoteDataSource.signUp(
            email: email,
            phone: phone,
            password: password,
            firstName: firstName,
            lastName: lastName,
            socialProfile: socialProfile,
            imageUrl: imageUrl);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(ServerFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, UserCredential>> signInWithGoogle() async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await signUpRemoteDataSource.signInWithGoogle();
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(ServerFailure(failure: Constants.internetFailure));
    }
  }

  @override
  Future<Either<Failures, void>> setUserModel(
      {required String userModel}) async {
    try {
      final response = await localDataSource.setUserModel(userModel: userModel);
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: Constants.cacheFailure));
    }
  }
}
