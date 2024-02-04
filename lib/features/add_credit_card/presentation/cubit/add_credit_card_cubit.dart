import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  bool _mustCheck = false;

  bool get mustCheck => _mustCheck;

  set setMustCheck(bool value) {
    emit(SetAndGetValueLoading());
    _mustCheck = value;
    emit(SetAndGetValueLoaded());
  }

  Future<void> addNewCard(
      {required bool isFromEdit}) async {
    try {
      final response = await addNewCardUseCase(AddNewCardUseCaseParams(
        walletId: walletId,
        isFromEdit: isFromEdit,
        holderName: cardHolderNameController.text,
        cardNumber: cardNumberController.text,
        expiryDate: expirationDateController.text,
      ));
      response
          .fold((failure) => emit(AddCreditCardError(failure: failure.failure)),
              (success) {
        emit(AddCreditCardLoaded(isAdded: success));
      });
    } catch (error) {
      emit(AddCreditCardError(failure: error.toString()));
    }
  }

  bool checkIfThereAreEmptyField() {
    return cardNumberController.text.isEmpty ||
        cardHolderNameController.text.isEmpty ||
        expirationDateController.text.isEmpty;
  }

  bool isCardNumberCorrect() {
    return cardNumberController.text.length == 14;
  }

  void resetValues(bool isFromEdit) {
    if (!isFromEdit) {
      cardNumberController.clear();
      cardHolderNameController.clear();
      expirationDateController.clear();
      walletId = 0;
    }
    _mustCheck = false;
  }
}
