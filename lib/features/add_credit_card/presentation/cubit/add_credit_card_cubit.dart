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

  Future<void> addNewCard({required int userId}) async {
    try {
      final response = await addNewCardUseCase(AddNewCardUseCaseParams(
          userId: userId,
          holderName: cardHolderNameController.text,
          cardNumber: cardNumberController.text,
          month: expirationDateController.text.split('/').first,
          year: expirationDateController.text.split('/').last));
      response.fold(
          (failure) => emit(AddCreditCardError(failure: failure.failure)),
          (success) => emit(AddCreditCardLoaded()));
    } catch (error) {
      emit(AddCreditCardError(failure: error.toString()));
    }
  }

  bool checkIfThereAreEmptyField() {
    return cardNumberController.text.isEmpty ||
        cardHolderNameController.text.isEmpty ||
        expirationDateController.text.isEmpty;
  }
}
