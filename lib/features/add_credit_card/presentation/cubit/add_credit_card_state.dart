part of 'add_credit_card_cubit.dart';

abstract class AddCreditCardState extends Equatable {
  const AddCreditCardState();
}

class AddCreditCardInitial extends AddCreditCardState {
  @override
  List<Object> get props => [];
}

class AddCreditCardLoading extends AddCreditCardState {
  @override
  List<Object> get props => [];
}

class AddCreditCardLoaded extends AddCreditCardState {
  final AddCardModel addCardModel;

  const AddCreditCardLoaded({required this.addCardModel});
  @override
  List<Object> get props => [addCardModel];
}

class AddCreditCardError extends AddCreditCardState {
  final String failure;

  const AddCreditCardError({required this.failure});

  @override
  List<Object> get props => [failure];
}
