import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/valet/data/model/guest_price_model.dart';
import 'package:prestige_valet_app/features/valet/domain/repository/valet_repository.dart';

class GetGuestPriceUseCase extends UseCase<GuestPriceModel, GetGuestPriceUseCaseParams> {
  final ValetRepository repository;

  GetGuestPriceUseCase({required this.repository});

  @override
  Future<Either<Failures, GuestPriceModel>> call(GetGuestPriceUseCaseParams params) async {
    return await repository.getGuestPrice(params.valetId);
  }
}

class GetGuestPriceUseCaseParams extends Equatable {
  final int valetId;

  const GetGuestPriceUseCaseParams({required this.valetId});

  @override
  List<Object?> get props => [valetId];
}
