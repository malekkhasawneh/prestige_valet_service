import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/add_credit_card/domain/repository/add_card_repository.dart';

class AddNewCardUseCase extends UseCase<bool, AddNewCardUseCaseParams> {
  final AddCardRepository repository;

  AddNewCardUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(AddNewCardUseCaseParams params) async {
    return await repository.addNewCard(
        walletId: params.walletId,
        holderName: params.holderName,
        cardNumber: params.cardNumber,
        expiryDate: params.expiryDate,
        isFromEdit: params.isFromEdit);
  }
}

class AddNewCardUseCaseParams extends Equatable {
  final int walletId;
  final String holderName;
  final String cardNumber;
  final String expiryDate;

  final bool isFromEdit;

  const AddNewCardUseCaseParams(
      {required this.walletId,
      required this.isFromEdit,
      required this.holderName,
      required this.cardNumber,
      required this.expiryDate});

  @override
  List<Object?> get props => [holderName, cardNumber, walletId, isFromEdit];
}
