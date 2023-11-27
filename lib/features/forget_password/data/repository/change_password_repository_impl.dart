import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/forget_password/data/datasource/change_password_remote_datasource.dart';
import 'package:prestige_valet_app/features/forget_password/data/model/change_password_model.dart';
import 'package:prestige_valet_app/features/forget_password/domain/repository/change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChangePasswordRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, ChangePasswordModel>> changePassword(
      {required String password, required String email}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.changePassword(
            password: password, email: email);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }
}
