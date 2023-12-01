import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/features/add_credit_card/data/model/add_card_model.dart';
import 'package:prestige_valet_app/features/add_credit_card/domain/usecase/add_new_card_usecase.dart';

part 'add_credit_card_state.dart';

class AddCreditCardCubit extends Cubit<AddCreditCardState> {
  static AddCreditCardCubit get(BuildContext context) =>
      BlocProvider.of(context);

  AddCreditCardCubit({required this.addNewCardUseCase})
      : super(AddCreditCardInitial());

  final AddNewCardUseCase addNewCardUseCase;

  int previousLength = 0;

  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController billingAddressController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expirationDateController =
      TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  int walletId = 0;

  bool mustCheck = false;

  Future<void> addNewCard(
      {required int userId, required bool isFromEdit}) async {
    try {
      final response = await addNewCardUseCase(AddNewCardUseCaseParams(
          userId: userId,
          walletId: walletId,
          isFromEdit: isFromEdit,
          holderName: cardHolderNameController.text,
          cardNumber: cardNumberController.text,
          month: expirationDateController.text.substring(0, 2),
          year: expirationDateController.text.substring(2, 4)));
      response
          .fold((failure) => emit(AddCreditCardError(failure: failure.failure)),
              (success) {
        emit(AddCreditCardLoaded(addCardModel: success));
      });
    } catch (error) {
      emit(AddCreditCardError(failure: error.toString()));
    }
  }

  void checkIfThereAreEmptyField() {
    if (cardNumberController.text.isEmpty ||
        cardHolderNameController.text.isEmpty ||
        expirationDateController.text.isEmpty) {
      mustCheck = true;
    } else {
      mustCheck = false;
    }
    emit(AddCreditCardLoading());
  }

  void resetValues(bool isFromEdit) {
    if (!isFromEdit) {
      cardNumberController.clear();
      cardHolderNameController.clear();
      expirationDateController.clear();
      walletId = 0;
    }
    mustCheck = false;
  }
}
