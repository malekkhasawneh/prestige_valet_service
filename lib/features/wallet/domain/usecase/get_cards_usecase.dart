import 'package:dartz/dartz.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';
import 'package:prestige_valet_app/features/wallet/domain/repository/wallet_repository.dart';

class GetCardsUseCase extends UseCase<List<WalletModel>, NoParams> {
  final WalletRepository repository;

  GetCardsUseCase({required this.repository});

  @override
  Future<Either<Failures, List<WalletModel>>> call(NoParams params) async {
    return await repository.getCards();
  }
}