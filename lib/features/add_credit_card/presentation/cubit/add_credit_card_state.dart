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
  final bool isAdded;

  const AddCreditCardLoaded({required this.isAdded});
  @override
  List<Object> get props => [isAdded];
}

class AddCreditCardError extends AddCreditCardState {
  final String failure;

  const AddCreditCardError({required this.failure});

  @override
  List<Object> get props => [failure];
}
//Set And Get Values States
class SetAndGetValueLoading extends AddCreditCardState {
  @override
  List<Object> get props => [];
}

class SetAndGetValueLoaded extends AddCreditCardState {
  @override
  List<Object> get props => [];
}
