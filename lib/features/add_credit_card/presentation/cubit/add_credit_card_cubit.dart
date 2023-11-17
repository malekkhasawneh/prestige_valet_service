import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_credit_card_state.dart';

class AddCreditCardCubit extends Cubit<AddCreditCardState> {
  static AddCreditCardCubit get(BuildContext context) =>
      BlocProvider.of(context);

  AddCreditCardCubit() : super(AddCreditCardInitial());

  int previousLength = 0;

  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController billingAddressController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expirationDateController =
      TextEditingController();
  final TextEditingController cvvController =
  TextEditingController();
}
