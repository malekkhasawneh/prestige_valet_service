import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prestige_valet_app/core/errors/failures.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/add_credit_card/data/model/add_card_model.dart';
import 'package:prestige_valet_app/features/add_credit_card/domain/repository/add_card_repository.dart';

class AddNewCardUseCase extends UseCase<AddCardModel, AddNewCardUseCaseParams> {
  final AddCardRepository repository;

  AddNewCardUseCase({required this.repository});

  @override
  Future<Either<Failures, AddCardModel>> call(
      AddNewCardUseCaseParams params) async {
    return await repository.addNewCard(
        userId: params.userId,
        walletId: params.walletId,
        holderName: params.holderName,
        cardNumber: params.cardNumber,
        month: params.month,
        year: params.year,
        isFromEdit: params.isFromEdit);
  }
}

class AddNewCardUseCaseParams extends Equatable {
  final int userId;
  final int walletId;
  final String holderName;
  final String cardNumber;
  final String month;
  final String year;
  final bool isFromEdit;

  const AddNewCardUseCaseParams(
      {required this.userId,
      required this.walletId,
      required this.isFromEdit,
      required this.holderName,
      required this.cardNumber,
      required this.month,
      required this.year});

  @override
  List<Object?> get props =>
      [userId, holderName, cardNumber, month, year, walletId,isFromEdit];
}
