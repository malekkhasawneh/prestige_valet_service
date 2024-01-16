import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfatoorah_flutter/MFModels.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';
import 'package:prestige_valet_app/features/wallet/domain/usecase/execute_payment_usecase.dart';
import 'package:prestige_valet_app/features/wallet/domain/usecase/get_cards_usecase.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  static WalletCubit get(BuildContext context) => BlocProvider.of(context);

  WalletCubit({
    required this.getCardsUseCase,
    required this.executePaymentUseCase,
  }) : super(WalletInitial());

  final GetCardsUseCase getCardsUseCase;
  final ExecutePaymentUseCase executePaymentUseCase;

  double bodyBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.7) - 56;

  double headerBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.3) - 2;

  Future<void> getCards({required int userId}) async {
    emit(WalletLoading());
    try {
      final response =
          await getCardsUseCase(GetCardsUseCaseParams(userId: userId));
      response.fold((failure) {
        log('=================================== ooo ${failure.failure}');

        emit(WalletError(failure: failure.failure));
      },
          (success) {
        log('=================================== ooo ${success.length}');
        emit(WalletLoaded(model: success));
      });
    } catch (failure) {
      emit(WalletError(failure: failure.toString()));
    }
  }

  Future<void> executePayment(
      {required String cardNumber,
      required String cardHolderName,
      required String expiryDate,
      required String cvv,
      required String amount}) async {
    emit(ExecutePaymentLoading());
    try {
      final response = await executePaymentUseCase(ExecutePaymentUseCaseParams(
          cardNumber: cardNumber,
          cardHolderName: cardHolderName,
          expiryDate: expiryDate,
          cvv: cvv,
          amount: amount));
      response.fold((failure) => emit(WalletError(failure: failure.failure)),
          (success) {
        emit(
          ExecutePaymentLoaded(
            model: success,
          ),
        );
      });
    } catch (failure) {
      emit(WalletError(failure: failure.toString()));
    }
  }
}
