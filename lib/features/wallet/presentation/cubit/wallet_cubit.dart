import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';
import 'package:prestige_valet_app/core/usecase/usecase.dart';
import 'package:prestige_valet_app/features/wallet/data/model/wallet_model.dart';
import 'package:prestige_valet_app/features/wallet/domain/usecase/get_cards_usecase.dart';
import 'package:prestige_valet_app/features/wallet/domain/usecase/send_payment_usecase.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  static WalletCubit get(BuildContext context) => BlocProvider.of(context);

  WalletCubit({
    required this.getCardsUseCase,
    required this.sendPaymentUseCase,
  }) : super(WalletInitial());

  final GetCardsUseCase getCardsUseCase;
  final SendPaymentUseCase sendPaymentUseCase;

  double bodyBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.7) - 56;

  double headerBoxHeight(BuildContext context, double screenHeight) =>
      (screenHeight * 0.3) - 2;

  List<String> existingCardsNumber = [];

  Future<void> getCards() async {
    emit(WalletLoading());
    try {
      final response = await getCardsUseCase(NoParams());
      response.fold(
            (failure) => emit(
          WalletError(
            failure: failure.failure,
          ),
        ),
            (cards) {
          for (var card in cards) {
            existingCardsNumber.add(card.cardNumber);
          }
          emit(
            WalletLoaded(model: cards),
          );
        },
      );
    } catch (failure) {
      emit(
        WalletError(
          failure: failure.toString(),
        ),
      );
    }
  }

  bool isCardAlreadyExist(String cardNumber) {
    bool isCardExist = false;
    for (var card in existingCardsNumber) {
      if (card.contains(cardNumber)) {
        isCardExist = true;
      }
    }
    return isCardExist;
  }

   String cardHolderName = '';
   String cardNumber = '';
   String month = '';
   String year = '';
   String cvv = '';

  executeDirectPayment(int paymentMethodId, bool isToken, String amount) async {
    emit(ExecutePaymentLoading());
    try {
      var request = MFExecutePaymentRequest(
          paymentMethodId: paymentMethodId, invoiceValue: double.parse(amount));

      var token = isToken ? "TOKEN210282" : null;
      var mfCardRequest = isToken
          ? null
          : MFCard(
              cardHolderName: cardHolderName,
              number: cardNumber,
              expiryMonth: month,
              expiryYear: year,
              securityCode: cvv,
            );

      var directPaymentRequest = MFDirectPaymentRequest(
          executePaymentRequest: request, token: token, card: mfCardRequest);
      log('$directPaymentRequest');
      await MFSDK
          .executeDirectPayment(
              directPaymentRequest, MFLanguage.ENGLISH, (invoiceId) {})
          .then(
            (value) => emit(
              ExecutePaymentLoaded(
                  status: value.cardInfoResponse!.status ==
                      Constants.paymentSuccess),
            ),
          )
          .catchError(
            (error) => emit(
              ExecutePaymentError(error: error),
            ),
          );
    } catch (error) {
      emit(ExecutePaymentError(error: error.toString()));
    }
  }

  executeRegularPayment(int paymentMethodId, String amount) async {
    emit(ExecutePaymentLoading());
    try {
      var request = MFExecutePaymentRequest(
          paymentMethodId: paymentMethodId, invoiceValue: double.parse(amount));
      request.displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;

      await MFSDK
          .executePayment(request, MFLanguage.ENGLISH, (invoiceId) {
            log(invoiceId);
          })
          .then((value) => emit(
                ExecutePaymentLoaded(
                    status: value.invoiceStatus == Constants.paymentSuccess),
              ))
          .catchError((error) => emit(ExecutePaymentError(error: error)));
    } catch (error) {
      emit(ExecutePaymentError(error: error.toString()));
    }
  }

  Future<void> sendPayment(
      {required String type,
      required String amount,
      required int userId,
      required int gateId,
      required int parkingId}) async {
    emit(SendPaymentLoading());
    try {
      final response = await sendPaymentUseCase(SendPaymentUseCaseParams(
          type: type,
          amount: amount,
          userId: userId,
          gateId: gateId,
          parkingId: parkingId));
      response.fold((l) => emit(SendPaymentError(error: l.failure)),
          (r) => emit(SendPaymentLoaded(status: r)));
    } catch (error) {
      emit(SendPaymentError(error: error.toString()));
    }
  }
}
