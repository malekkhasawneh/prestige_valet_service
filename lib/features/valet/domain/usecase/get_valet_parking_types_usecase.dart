import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/valet/data/model/valet_parking_types.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';

class GetValetParkingTypesUseCase
    extends UseCase<List<ValetParkingTypes>, GetValetParkingTypesUseCaseParams> {
  final ValetRepository repository;

  GetValetParkingTypesUseCase({required this.repository});

  @override
  Future<Either<Failures, List<ValetParkingTypes>>> call(
      GetValetParkingTypesUseCaseParams params) async {
    return await repository.getValetParkingTypes(params.gateId);
  }
}

class GetValetParkingTypesUseCaseParams extends Equatable {
  final int gateId;

  const GetValetParkingTypesUseCaseParams({required this.gateId});

  @override
  List<Object?> get props => [gateId];
}
