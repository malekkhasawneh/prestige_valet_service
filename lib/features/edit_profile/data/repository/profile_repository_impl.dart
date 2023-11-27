import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/exceptions.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/edit_profile/data/datasource/profile_remote_datasource.dart';
import 'package:prestige_valet_app/features/edit_profile/domain/repository/profile_repository.dart';
import 'package:prestige_valet_app/features/sign_up/data/model/registration_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, User>> editProfile(
      {required int userId,
      required String firstName,
      required String lastName,
      required String phone,
      required String email}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.editProfile(
            userId: userId,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            email: email);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: Constants.serverFailure));
      }
    } else {
      return const Left(InternetFailure(failure: Constants.internetFailure));
    }
  }
}
