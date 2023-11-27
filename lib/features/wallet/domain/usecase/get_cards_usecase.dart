import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';
import 'package:prestige_valet_app/features/wallet/domain/repository/wallet_repository.dart';

class GetCardsUseCase extends UseCase<List<WalletModel>, GetCardsUseCaseParams> {
  final WalletRepository repository;

  GetCardsUseCase({required this.repository});

  @override
  Future<Either<Failures, List<WalletModel>>> call(
      GetCardsUseCaseParams params) async {
    return await repository.getCards(userId: params.userId);
  }
}

class GetCardsUseCaseParams extends Equatable {
  final int userId;

  const GetCardsUseCaseParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
