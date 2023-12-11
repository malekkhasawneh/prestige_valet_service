import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/network/network_info.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/features/pick_up/data/datasource/pick_up_remote_datasource.dart';
import 'package:prestige_valet_app/features/pick_up/data/model/gates_model.dart';
import 'package:prestige_valet_app/features/pick_up/domain/repository/pick_up_repository.dart';

class PickUpRepositoryImpl implements PickUpRepository {
  final PickUpRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PickUpRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, GatesModel>> getGates({required int locationId}) async {
    if (await networkInfo.checkConnection()) {
      final response = await remoteDataSource.getGates(locationId: locationId);
      return Right(response);
    } else {
      return const Left(InternetFailure(failure: Constants.cacheFailure));
    }
  }
}
